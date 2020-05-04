module Lunchbot
  module Commands
    class RecipeSearch < SlackRubyBot::Commands::Base
      command "recipes"
      command "recipe"
      command "make"

      help do
        title "recipes"
        desc "Search for recipes"
        long_desc "Try asking me for soup recipes: 'recipes soup' or 'make soup'!"
      end

      def self.call(client, data, match)
        query = match[:expression]
        response = RecipeService.new({endpoint: "/search", number: 3, query: query}).search
        
        puts response

        ids = response["results"].map { |recipe| recipe["id"] }.join(",")
        recipes = RecipeService.new({endpoint: "/informationBulk", ids: ids})

        client.web_client.chat_postMessage(
          as_user: true,
          token: client.token,
          channel: data.channel,
          attachments: recipes.map { |recipe| RecipeFormatter.format_recipe(recipe) }
        )
      end
    end
  end
end
