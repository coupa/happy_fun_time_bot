require 'httparty'
class Answers < ResponderType
  HelpText  = "Look up a question in Yahoo Answers"
  Command   = 'question'
  AppId     = YAML.load_file(File.expand_path('../../../config/yahoo.yml', __FILE__))["app_id"]
  
  include HTTParty
  format :xml

  BaseUri   = "http://answers.yahooapis.com/AnswersService/V1/questionSearch?appid=#{AppId}&query="

  class << self    
    def respond(from, question)
      response = Answers.get(BaseUri + URI.escape(question))
      %Q{Q: #{response["ResultSet"]["Question"][0]["Subject"]}\nA: #{response["ResultSet"]["Question"][0]["ChosenAnswer"]}}
    end
  end
end