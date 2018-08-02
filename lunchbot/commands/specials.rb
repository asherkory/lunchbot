module Lunchbot
  module Commands
    class Specials < SlackRubyBot::Commands::Base

      help do
        title "specials"
        desc "Lists nearby open restaurants with lunch specials."
        long_desc "Ask me about 'specials'!"
      end

      command "specials" do |client, data, match|
        response = YelpService.new({term: "lunch specials", limit: 5}).search
        client.web_client.chat_postMessage(
          as_user: true,
          token: client.token,
          channel: data.channel,
          attachments: format_attachments(response)
        )
      end

      def self.format_attachments(response)
        if response["businesses"].empty?
          [{
            fallback: "No restaurants found",
            title: ":(",
            text: "No restaurants found.",
            color: "#f2e540"
          }]
        else
          response["businesses"].map do |business|
            details = "#{business["price"]} #{business["categories"].map{|c| c["title"]}.join(", ")}\n#{business["location"]["address1"]}"
            {
              fallback: business["name"], 
              title: business["name"], 
              title_link: business["url"], 
              text: details, 
              thumb_url: business["image_url"],
              color: "#df3612"
            }
          end
        end
      end
    end
  end
end