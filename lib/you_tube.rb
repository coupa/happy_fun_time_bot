require 'rubygems'
require 'httparty'
require 'ruby-debug'
# Let's create a simple image getter from google.
class YouTube
  include HTTParty
  format :json

  def self.get_youtube_url(search)
    res = YouTube.get("http://gdata.youtube.com/feeds/api/videos?q=#{URI.escape(args)}&alt=json")
    res["feed"]["entry"][0]["link"][0]['href']
  end
end