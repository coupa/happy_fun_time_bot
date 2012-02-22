class ClearScreen < ResponderType
  HelpText  = "clears screen of naughty"
  Command   = '!'
  
  class << self    
    def respond(from, question)
      message = (1..7).collect{|i| " "}.join("\n")
      4.times do Bot.send(:send_response, message)
        message
      end
      message
    end
  end
end
