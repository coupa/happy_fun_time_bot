#!/usr/bin/env ruby

require 'rubygems'
require 'xmpp4r'
require 'xmpp4r/muc/helper/simplemucclient'
require 'open-uri'
require 'cgi'

$: << File.expand_path(File.dirname(__FILE__))

require 'responder'
require 'bot/muc_client'
require 'google'
require 'urban_dictionary'

class HappyFunTimeBot
  attr_accessor :config, :client, :muc, :responders, :command_regexp

  def initialize(config = {})
    config = {:command_regex => /^!(.+)$/}.merge(config)
    self.client = Jabber::Client.new(config[:jid])
    self.muc    = Jabber::MUC::SimpleMUCClient.new(client)
    self.command_regexp = /^!(.+)$/
    self.responders = []
    self.config = config

    Jabber.debug = true if Jabber.logger = config[:debug]
    self.add_responder('help', :help_text => 'List Available Commands') do |from, args|
      self.help
    end
    self
  end

  def help
    commands = self.responders.map{|r| "#{r.command}#{" -> #{r.options[:help_text]}" if r.options[:help_text]}"}.join("\n")
    "Available Commands\n#{commands}"
  end

  def connect
    client.connect
    client.auth(self.config[:password])
    client.send(Jabber::Presence.new.set_type(:available))

    salutation = config[:nick].split(/\s+/).first

    muc.on_message { |time, nick, text| process(nick, text) }

    muc.join(self.config[:room] + '/' + self.config[:nick])
    self
  end

  def add_responder(command  = nil, options = {}, &block)
    responders << Responder.new(command, options, &block)
  end

  def run!
    connect
    loop { sleep 1 }
  end

  private

  def process(from, command)
    File.open("../log/debug.log", 'a') {|f| f.write("Running process(#{from}, #{command})\n") }
    return [] if !responders.any? {|r| r.command.nil? } and !(command =~ self.config[:command_regex])

    responders.select {|r| r.responds_to?($1) }.map  do |responder|
      args = command.split
      args.shift
      ret = responder.block.call(from, args.join(' '))
      send_response(ret)
      ret
    end
  rescue => e
    File.open("../log/debug.log", 'a') {|f| f.write("\n#{e.message}\n\n#{e.backtrace.to_yaml}\n") }
  end

  def send_response(msg)
    muc.send Jabber::Message.new(muc.room, msg)
  end
end
