module Lunchbot
  module Commands
    class HomeLunch < SlackRubyBot::Commands::Base
      command "wfh lunch"
      command "remote lunch"
      command "home lunch"

      # might have to edit existing lunch command to avoid double matches:
      # use 'command' method instead of 'match' and pass today/tomorrow as args

      help do
        title "wfh lunch"
        desc "Finds a random lunch recipe."
        long_desc "Ask me for a 'wfh lunch'!"
      end

      def self.call(client, data, match)
        response = RecipeService.new({endpoint: "random", number: 1, tags: "lunch"}).search
        client.web_client.chat_postMessage(
          as_user: true,
          token: client.token,
          channel: data.channel,
          attachments: [RecipeFormatter.format_recipe(response["recipes"].first)]
        )
      end
    end
  end
end
