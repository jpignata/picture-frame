class Channel
  attr_reader :last_message

  def initialize
    @channel = EventMachine::Channel.new
  end

  def subscribe(&block)
    @channel.subscribe(&block)
  end

  def publish(message)
    @last_message = message
    @channel.push(message)
  end
end
