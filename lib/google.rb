require 'rubygems'
require 'httparty'
require 'ruby-debug'
# Let's create a simple image getter from google.
class Google
  include HTTParty
  format :json

  def self.image_url_list(results)
    (0..(results['responseData']['results'].length - 1)).collect do |index|
      results['responseData']['results'][index]['url']
    end.sort_by do rand end
  end
  
  def self.grab_tested_image_url(results, url_list = nil)
    url_list = image_url_list(results) if !url_list
    url = url_list.pop
    
    raise RuntimeError if !url
    
    Timeout::timeout(8) do
      response = HTTParty.get(url).response
      if response.code == '200' && response.content_type != 'text/html'      
        url
      else
        grab_tested_image_url(results, url_list)
      end
    end    
  end
  
  def self.get_image_url(search, options = {:start => 0})
    if options[:random]
      options[:start] = rand(12)
    end

    results = Google.get("https://ajax.googleapis.com/ajax/services/search/images?v=1.0&safe=active&start=#{options[:start]}&rsz=8&q=#{URI.escape(search)}")
    
    begin
      grab_tested_image_url(results)
    rescue => e
      e.to_s
    end
  end

  def self.get_definition(search)
    result = Google.get("http://www.google.com/dictionary/json?callback=dict_api.callbacks.id100&q=#{search}&sl=en&tl=en&restrict=pr%2Cde&client=te")
    meanings = result['primaries']['entries'].select{|entry| entry["type"] == 'meaning' }.join('\n')
    meanings
  end

  def self.get_youtube_url(search)
    res = Google.get("http://gdata.youtube.com/feeds/api/videos?q=#{URI.escape(args)}&alt=json")
    res["feed"]["entry"][0]["link"][0]['href']
  end
end
