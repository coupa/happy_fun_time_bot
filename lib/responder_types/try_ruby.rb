require 'rubygems'
require 'httparty'
require 'ruby-debug'

class TryRuby < ResponderType
  HelpText  = "Evaluate ruby code"
  Command   = 'eval'
  
  include HTTParty

  GetUri    = "http://tryruby.org/levels/1/challenges/0"
  BaseUri   = "http://tryruby.org/levels/1/challenges/0/play"
  format :json      

  class << self    
    def respond(from, command)
      first_hit   = hit_the_page
      csrf_token  = first_hit.body.match(/.+name=\"csrf-token\"/)[0].gsub(/<meta content=\"/, "").gsub(/\" name=\"csrf-token\"/, "")
      cookie      = first_hit.headers["set-cookie"].split(';')[0]

      response = lambda{TryRuby.put(
        BaseUri, 
        :body => {},
        :query => {"cmd" => command},
        :headers => { 
          'Accept'              => 'application/json, text/javascript, */*; q=0.01',
          'Accept-Encoding'     => "gzip, deflate",
          "Accept-Language"     => "en-us,en;q=0.5",
          "Connection"          => "keep-alive",
          "Content-Type"	      => "application/x-www-form-urlencoded; charset=UTF-8",
          "Cookie"              => cookie,
          "Host"                => "tryruby.org",
          "Referer"	            => "http://tryruby.org/levels/1/challenges/0",
          "X-CSRF-Token"	      => csrf_token,
          "X-Requested-With"	  => "XMLHttpRequest"
        }
      )}
       
       MultiJson.decode(response["output"].body)["output"]
    end
    
    def hit_the_page
      format :plain      
      TryRuby.get(GetUri)
    end
  end
end