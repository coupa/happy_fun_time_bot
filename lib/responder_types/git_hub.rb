require 'rubygems'
require 'httparty'
class GitHub < ResponderType
  HelpText    = "Post link to a specific commit"
  Command     = 'git'
  Config      = YAML.load_file(File.expand_path('../../../config/github.yml', __FILE__))
  Owner       = Config["repository_owner"]
  Repo        = Config["repository_name"]

  BaseUri   = "https://github.com/#{Owner}/#{Repo}/commit/"

  class << self    
    def respond(from, commit_hash)
      BaseUri + URI.escape(commit_hash)
    end
  end
end