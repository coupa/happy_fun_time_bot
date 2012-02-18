class GoogleDictionary < ResponderType
  HelpText  = "Look up a definition"
  Command   = 'def'
  
  include HTTParty
  format :plain

  BaseUri   = "http://www.google.com/dictionary/json?callback=hipchat&sl=en&tl=en&restrict=pr%2Cde&client=te&q="

  class << self    
    def respond(from, question)
       raw = MultiJson.decode(GoogleDictionary.get(BaseUri + question).gsub('hipchat(', '').gsub(',200,null)', ''))
       entries = raw["primaries"][0]["entries"] if raw && raw["primaries"] && raw["primaries"][0]
       
       meanings = entries.collect do |entry|
         entry["terms"][0]['text'] if entry && entry["terms"] && entry["terms"][0]
       end.compact
       
       meanings.each_with_index do |definition, index|
         meanings[index] = "#{index + 1}. #{definition}"
       end
       
       %Q{Definition for '#{question}'\n#{meanings.join("\n")}}
    end
  end
end