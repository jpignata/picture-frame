require "http_router"

require_relative "actions/subscribe"
require_relative "actions/publish"
require_relative "body"
require_relative "channel"
require_relative "flickr_search"
require_relative "flickr_result"

class PictureFrame
  def self.app
    @routes ||= HttpRouter.new do
      post("/publish").
         to { |env| Actions::Publish.new(env, PictureFrame.channel).run }
      get("/subscribe").
        to { |env| Actions::Subscribe.new(env, PictureFrame.channel).run }
      add("/").static("public/index.html")
      add("/").static("public")
    end
  end

  def self.channel
    @channel ||= Channel.new
  end
end

