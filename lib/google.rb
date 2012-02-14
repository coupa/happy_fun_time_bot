require 'httparty'
# Let's create a simple image getter from google.
class Google
  include HTTParty
  format :json

  def self.get_image_url(search, options = {:start => 0})
    if options[:random]
      options[:start] = rand(12)
    end

    res = Google.get("https://ajax.googleapis.com/ajax/services/search/images?v=1.0&safe=active&start=#{options[:start]}&rsz=8&q=#{URI.escape(search)}")
    
    begin
      "Look! #{res['responseData']['results'][rand(8)]['url']}"
    rescue
      "Sorry! No image found."
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
