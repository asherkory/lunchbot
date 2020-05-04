module Lunchbot
  class RecipeService
    include HTTParty

    BASE_URI = "https://api.spoonacular.com/recipes"

    DEFAULT_QUERY = {
      apiKey: ENV["SPOONACULAR_API_KEY"]
    }

    def initialize(params = {})
      @uri = "#{BASE_URI}#{params[:endpoint]}"
      @query = DEFAULT_QUERY.merge!(params)
    end

    def search
      @response = HTTParty.get(@uri, query: @query)
    end
  end
end
