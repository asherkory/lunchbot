module Lunchbot
  module Commands
    class RecipeSearch < SlackRubyBot::Commands::Base
      # recipe for term

      help do
      end

      command "recipe for" do |client, data, match|
        term = match[:expression]
        response = RecipeService.new().search
      end
    end
  end
end
