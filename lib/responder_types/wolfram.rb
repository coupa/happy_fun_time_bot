require 'rubygems'
require 'httparty'
require 'ruby-debug'
# Let's create a simple image getter from google.
class Wolfram < ResponderType
  HelpText  = "Search Wolfram Alpha for knowledge"
  Command   = 'wolfram'
  
  AppId     = YAML.load_file(File.expand_path('../../../config/wolfram.yml', __FILE__))["app_id"]
  BaseUri   = "http://api.wolframalpha.com/v2/query?appid=#{AppId}&input="
  
  include HTTParty
  format :xml
  
  class << self  
    def respond(from, search)
      response = Wolfram.get(BaseUri + URI.escape(search))
      pods     = response['queryresult']["pod"]
      subpods  = pods.collect{|pod| pod["subpod"].is_a?(Hash) ? [pod["subpod"]] : pod["subpod"]}.flatten
      images   = subpods.select{|subpod| !subpod["plaintext"] }.collect{|subpod| subpod["img"]["src"]}.collect{|img| img + '.jpg'}
      images.each do |image| Bot.send(:send_response,image) end
      
      subpods.select{|subpod| subpod["plaintext"] }.collect{|subpod| subpod["plaintext"]}.flatten.join("\n")      
    end
  end
end