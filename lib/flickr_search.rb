require "em-http-request"
require "json"
require "uri"

class FlickrSearch
  include EM::Deferrable

  def initialize(search)
    @search = search
  end

  def get
    request = EM::HttpRequest.new(url).get
    request.callback { |http|
      result = FlickrResult.new(http.response, @search)

      if result.success?
        succeed(result)
      else
        fail
      end
    }

    request.errback { fail }

    self
  end

  private

  def url
    [
      "http://api.flickr.com/services/rest/?method=flickr.photos.search",
      "&api_key=#{api_key}",
      "&text=#{URI.escape(@search)}",
      "&sort=relevance",
      "&per_page=100",
      "&format=json",
      "&nojsoncallback=1"
    ].join
  end

  def api_key
    ENV.fetch("FLICKR_API_KEY") { raise "FLICKR_API_KEY ENV key not set" }
  end
end
