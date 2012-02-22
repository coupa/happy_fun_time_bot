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
      
      pods     = {}
      if response['queryresult'] && response['queryresult']['pod'] 
        pods = response['queryresult']["pod"]
      elsif response["queryresult"] && response["queryresult"]["assumptions"]
        new_search = response["queryresult"]["assumptions"]["assumption"]["value"][0]["name"] + ' ' + search
        return respond(from, new_search)
      else
        return "Even the vast knowledge of wolfram cannot help you with '#{search}'"
      end  
      
      pods      = [pods] if pods.is_a?(Hash)
      subpods  = pods.collect{|pod| pod["subpod"].is_a?(Hash) ? [pod["subpod"]] : pod["subpod"]}.flatten
      images   = subpods.select{|subpod| !subpod["plaintext"] }.collect{|subpod| subpod["img"]["src"]}.collect{|img| img + '.jpg'}
      images.each do |image| Bot.send(:send_response,image) end
      subpods.select{|subpod| subpod["plaintext"] }.collect{|subpod| subpod["plaintext"]}.flatten.join("\n")      
    end
  end
end