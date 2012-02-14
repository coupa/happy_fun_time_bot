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
  "Correct! (cyn)"
end

@bot.run!
