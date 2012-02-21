class ResponderType
  class << self
    def add_responder_to(bot, options = {})
      bot.add_responder((options[:command] || self::Command), :help_text => (options[:help_text] || self::HelpText)) do |from, args|
        respond(from, args)
      end
    end
    
    def respond
      raise RuntimeError.new("Please implement the respond method in your reponder type class")
    end
  end
end