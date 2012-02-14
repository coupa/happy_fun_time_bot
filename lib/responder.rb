class Responder
  attr_accessor :command, :block, :options

  def initialize(command, options ={}, &block)
    @command = command
    @options = options
    @block = block
  end

  def responds_to?(command)
    # respond to all if our command is nil.
    return true if @command.nil?

    # otherwise parse out the command and make sure it matches
    # our command.
    @command == command.split.first
  end
end
