#!/usr/bin/env ruby
require 'rubygems'
require '../lib/happy_fun_time_bot.rb'

# For hipchat, your :jid, :room and :password are available at https://www.hipchat.com/account/xmpp
config = YAML.load_file('../config/hipchat.yml')

@bot = HappyFunTimeBot.new(
  :jid => config["jid"], 
  :nick => config["nick"], 
  :room => config["room"], 
  :password => config["password"]
)

# let's find some images!
@bot.add_responder('image', :help_text => "Search Google for an Image") do |from, args|
  Google.get_image_url(args)
end

@bot.add_responder('slang', :help_text => "Search UrbanDictionary for word") do |from, args|
  UrbanDictionary.get_term(args)
end

@bot.add_responder('define', :help_text => "Search Google for word Definition (not working)") do |from, args|
  Google.get_definition(args)
end

@bot.add_responder('correct', :help_text => "Ask CYN if something is correct") do |from, args|
  rand(2) == 1 ? "Correct! (cyn)" : "J.K. (cyn)"
end

@bot.add_responder('roll', :help_text => "Roll X dice that are each Y sided. XdY (e.g. 2d21)") do |from, args|
  matches = /(\d+)d(\d+)(.*)/.match(args)
  dice_count = $1.to_i
  sides = $2.to_i
  statement = $3
  return_val = "@" + from.split(" ").first + " "
  if dice_count <= 20 && sides <= 100
    dice_count.times do 
      return_val += rand(sides).to_s + " "
    end
    return_val += "=>" + statement
  else
    return_val = "I can't roll (allthethings)"
  end
  return_val
end

@bot.run!
