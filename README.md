# Happy fun time bot

Have happy fun times with this configurable XMPP bot!  It is SO easy to use, especially for Hipchat!

# Installation 

Please copy config/hipchat.example.yml over to config/hipchat.yml and edit appropriately.

For hipchat, your :jid, :room and :password are available at https://www.hipchat.com/account/xmpp

Copy config/yahoo.example.yml over to config/yahoo.yml and edit appropriately.

Get a Yahoo app id @ http://developer.yahoo.com/answers/


Add responders to bin/happy_fun_time_bot.rb

and to run:

>cd bin; ruby bin/happy_fun_time_bot.rb

Lets take a look!

```ruby
#!/usr/bin/env ruby

require 'rubygems'
require 'happy_fun_time_bot'

config = YAML.load_file('../config/hipchat.yml')

@bot = HappyFunTimeBot.new(
  :jid => config["jid"], 
  :nick => config["nick"], 
  :room => config["room"], 
  :password => config["password"]
)

@bot.add_responder('heybot') do |from, args|
  "Oh HAI #{from}!!!"
end

@bot.run!
```

```
Bob: !heybot what's up?
HappyFunTime Bot:  Oh HAI Bob!!!
```

### So many IdeazzZz!!

**Add responders to insert random images of dogs in costumes!**

```
Bob: !findimage dog costume
HappyFunTime Bot: Here ya go!
```
![](http://spoilurpets.com/images/Lobster%20Paws%20Dog%20Costume.JPG)


**Kick off a build!**

```
Bob: !build_the_app
HappyFunTime Bot: All tests PASSED!
```

![](http://thehairpin.com/wp-content/uploads/2010/12/womanpic1001_228x342.jpeg)

**Deploy your app!**

```
Bob: !deploy
HappyFunTime Bot: Deploying now!
```

### Bot creation Options:

* `:jid` - Required.
* `:nick` - The nickname for the bot to use.
* `:room` - Required.  The room to enter.
* `:password` - The bot's password.
* `:command_regex` - The regular expression to test for a command.  The default is a ! followed by a word.  e.g. `/^!(.+)$/`

## Copyright

Copyright (c) 2011 Grant Ammons. See LICENSE.txt for further details.
