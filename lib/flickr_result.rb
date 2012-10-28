class FlickrResult
  attr_reader :keyword

  def initialize(response, keyword)
    @response = response
    @keyword  = keyword
  end

  def success?
    !random_photo.nil?
  end

  def to_json
    { url: url, keyword: keyword } .to_json
  end

  private

  def parsed
    JSON.parse(@response)
  end

  def random_photo
    @random_photo ||= parsed["photos"] && parsed["photos"]["photo"].shuffle.first
  end

  def url
    "//farm%{farm}.staticflickr.com/%{server}/%{id}_%{secret}_z.jpg" % photo
  end

  def photo
    {
      id:     random_photo["id"],
      farm:   random_photo["farm"],
      server: random_photo["server"],
      secret: random_photo["secret"]
    }
  end
end
