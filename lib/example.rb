#!/usr/bin/env ruby
require 'rubygems'
require 'happy_fun_time_bot'

# For hipchat, your :jid, :room and :password are available at https://www.hipchat.com/account/xmpp
@bot = HappyFunTimeBot.new(:jid => "brent@coupa.com", :nick => "BrentBot", :room => "Product Team", :password => "j3rkface")

# calling !heybot will return a simple response.
@bot.add_responder('(primeminister)') do |from, args|
  "(plus_one)"
end

@bot.add_responder('@brent') do |from, args|
  "@brent is a king among men"
end
@bot.add_responder('(brent)') do |from, args|
  "(brent) is a king among men"
end

# endless loop.  Use bluepill or something else to daemonize it.
@bot.run!
