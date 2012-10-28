module Actions
  class Publish
    def initialize(env, channel)
      @env = env
      @channel = channel
    end

    def run
      search
      [200, headers, body]
    end

    private

    def search
      search = FlickrSearch.new(params["keyword"]).get

      search.callback do |result|
        @channel.publish(result)

        body.write(result.to_json)
        body.succeed
      end

      search.errback { body.fail }
    end

    def params
      @params ||= Rack::Utils.parse_query(@env["rack.input"].read)
    end

    def body
      @body ||= Body.new
    end

    def headers
      { "Content-Type" => "application/json" }
    end
  end
end
