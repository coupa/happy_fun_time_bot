#!/usr/bin/env ruby
%w(rubygems happy_fun_time_bot httparty).each {|r| require r }

# For hipchat, your :jid, :room and :password are available at https://www.hipchat.com/account/xmpp
@bot = HappyFunTimeBot.new(:jid => "xxxxx@chat.hipchat.com", :nick => "ImageBot", :room => "your_room@conf.hipchat.com", :password => "xxx")

# let's find some images!
@bot.add_responder('findimage') do |from, args|
  url = Google.get_image_url(args)
  "Look! #{url}"
end

@bot.run!
