module Actions
  class Subscribe
    def initialize(env, channel)
      @env = env
      @channel = channel
    end

    def run
      @channel.subscribe { |message| send_picture_event(message) }

      if @channel.last_message
        EventMachine.add_timer(0.1) { send_picture_event(@channel.last_message) }
      end

      [200, headers, body]
    end

    private

    def send_picture_event(data)
      body.write("event: picture\n")
      body.write("data: #{data.to_json}\n\n")
    end

    def body
      @body ||= Body.new
    end

    def headers
      {
        "Content-Type"  => "text/event-stream",
        "Connection"    => "keepalive",
        "Cache-Control" => "no-cache, no-store"
      }
    end
  end
end
