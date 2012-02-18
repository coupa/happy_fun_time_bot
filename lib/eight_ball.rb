class EightBall
  Answers = [
    "It is certain",
    "It is decidedly so",
    "Without a doubt",
    "Yes – definitely",
    "You may rely on it",
    "As I see it, yes",
    "Most likely",
    "Outlook good",
    "Signs point to yes",
    "Yes",

    "Reply hazy, try again",
    "Ask again later",
    "Better not tell you now",
    "Cannot predict now",
    "Concentrate and ask again",

    "Don't count on it",
    'My reply is no',
    "My sources say no",
    "Outlook not so good",
    "Very doubtful"
  ]
  
  def self.ask(from, question)
    "@#{from.split(' ')[0]}, #{question.gsub(' I ', ' you ').gsub(' i ', ' you ')}: #{Answers[rand(Answers.length - 1)]}"
  end
end
