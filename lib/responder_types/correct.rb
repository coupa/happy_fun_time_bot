class Correct < ResponderType
  HelpText  = "Ask CYN if something is correct"
  Command   = 'correct'
  
  class << self    
    def respond(from, question)
      rand(2) == 1 ? "Correct! (cyn)" : "J.K. (cyn)"
    end
  end
end
