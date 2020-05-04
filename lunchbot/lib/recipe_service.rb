module Lunchbot
  class RecipeService
    include HTTParty

    DEFAULT_QUERY = {
      apiKey: ENV["SPOONACULAR_API_KEY"]
    }

    def initialize(params = {})
      @uri = "https://api.spoonacular.com/"
      @query = DEFAULT_QUERY.merge!(params)
    end

    def search
      @response = HTTParty.get(@uri, query: @query)
    end
  end
end
