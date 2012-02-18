#!/usr/bin/env ruby
require 'rubygems'
require 'ruby-debug'
require File.expand_path('../../lib/happy_fun_time_bot.rb', __FILE__)

# For hipchat, your :jid, :room and :password are available at https://www.hipchat.com/account/xmpp
config = YAML.load_file(File.expand_path('../../config/hipchat.yml', __FILE__))

@bot = HappyFunTimeBot.new(
  :jid => config["jid"], 
  :nick => config["nick"], 
  :room => config["room"], 
  :password => config["password"]
)

# let's find some images!
@bot.add_responder('image', :help_text => "Search Google for an Image") do |from, args|
  Google.respond(from, args)
end

@bot.add_responder('vid', :help_text => "Search YouTube for a Video") do |from, args|
  YouTube.respond(from, args)
end

@bot.add_responder('slang', :help_text => "Search UrbanDictionary for word") do |from, args|
  UrbanDictionary.respond(from, args)
end

@bot.add_responder('correct', :help_text => "Ask CYN if something is correct") do |from, args|
  rand(2) == 1 ? "Correct! (cyn)" : "J.K. (cyn)"
end

@bot.add_responder('8ball', :help_text => "Ask Magic 8-ball a question") do |from, args|
  EightBall.respond(from, args)
end

@bot.add_responder('roll', :help_text => "Roll X dice that are each Y sided. XdY (e.g. 2d20)") do |from, args|
  Dice.respond(from, args)
end

@bot.run!
