class Jira < ResponderType
  HelpText  = "Give you a clickable link to Jira"
  Command   = 'jira'
  
  class << self    
    def respond(from, question)
      ticket_number = question.gsub(/[^0-9]/, '')
      if ticket_number && ticket_number.length > 0
        "Jira: https://coupadev.atlassian.net/browse/CD-" + ticket_number
      else
        "Jira: What kind of ticket of number is that?!"
      end
    end
  end
end