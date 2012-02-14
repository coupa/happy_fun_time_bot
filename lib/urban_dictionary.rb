require 'httparty'
# Let's create a simple image getter from google.
class UrbanDictionary
  include HTTParty
  format :json

  def self.get_term(search)
    res = UrbanDictionary.get("http://www.urbandictionary.com/iphone/search/define?term=#{URI.escape(search)}")
    definition = res['list'].first['definition'] || 'No definition found.'
    "#{search}: #{definition}"    
  end
end
