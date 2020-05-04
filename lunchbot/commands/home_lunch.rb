module Lunchbot
  module Commands
    class HomeLunch < SlackRubyBot::Commands::Base
      help do
        title "wfh lunch"
        desc "Finds a random lunch recipe."
        long_desc "Ask me for a 'wfh lunch', 'remote lunch', or 'home lunch'!"
      end

      match /(wfh|home|remote)\slunch/ do |client, data, match|
        response = RecipeService.new({endpoint: "/random", number: 1, tags: "lunch"}).search
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
