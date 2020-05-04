module Lunchbot
  module Commands
    class IngredientSearch < SlackRubyBot::Commands::Base
      command "what can I make with: "
      command "ingredient search: "

      help do
        title "ingredient search"
        desc "Search recipes by ingredients"
        long_desc "Try asking me 'what can I make with: tomatoes, cucumbers' or 'ingredient search: tomatoes, cucumbers'!"
      end

      def self.call(client, data, match)
        ingredients = match[:expression]
        response = RecipeService.new({endpoint: "/findByIngredients", number: 3, ingredients: ingredients}).search
        ids = response.map { |recipe| recipe["id"] }.join(",")
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
