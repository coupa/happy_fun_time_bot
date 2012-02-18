require 'rubygems'
require 'httparty'
require 'ruby-debug'
# Let's create a simple image getter from google.
class Google
  include HTTParty
  format :json

  class << self    
    def image_url_list(results)
      (0..(results['responseData']['results'].length - 1)).collect do |index|
        results['responseData']['results'][index]['url']
      end.sort_by do rand end
    end
  
    def grab_tested_image_url(results, url_list = nil)
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
  
    def get_image_url(from, search, options = {:start => 0})
      if options[:random]
        options[:start] = rand(12)
      end

      results = Google.get("https://ajax.googleapis.com/ajax/services/search/images?v=1.0&safe=active&start=#{options[:start]}&rsz=8&q=#{URI.escape(search)}")
    
      begin
        grab_tested_image_url(results)
      rescue
        "Sorry! No image found."
      end
    end
    
    alias :respond :get_image_url   
  end
end