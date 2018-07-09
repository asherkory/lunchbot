module Lunchbot
  class YelpService
    include HTTParty

    DEFAULT_QUERY = {
      latitude: "42.362917",
      longitude: "-71.083736",
      radius: 1200,
      open_now: true,
      categories: "restaurants"
    }

    def initialize(params = {})
      @uri = "https://api.yelp.com/v3/businesses/search"
      @headers = {"Authorization": "Bearer #{ENV['YELP_API_KEY']}"}
      @query = DEFAULT_QUERY.merge!(params)
    end

    def search
      @response = HTTParty.get(@uri, headers: @headers, query: @query)
    end
  end
end