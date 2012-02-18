require 'rubygems'
require 'httparty'
require 'ruby-debug'
# Let's create a simple image getter from google.
class YouTube
  include HTTParty
  format :json
  
  class << self  
    def get_youtube_url(from, search)
      res = YouTube.get("http://gdata.youtube.com/feeds/api/videos?q=#{URI.escape(search)}&alt=json")
      res["feed"]["entry"][0]["link"][0]['href']
    end
    
    alias :respond :get_youtube_url   
  end
end