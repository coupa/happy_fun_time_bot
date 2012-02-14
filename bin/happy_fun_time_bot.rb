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
@bot.add_responder('image') do |from, args|
  Google.get_image_url(args)
end

@bot.add_responder('define') do |from, args|
  UrbanDictionary.get_term(args)
end

@bot.run!
