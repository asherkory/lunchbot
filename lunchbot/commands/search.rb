module Lunchbot
  module Commands
    class Search < SlackRubyBot::Commands::Base
      help do
        title "search"
        desc "Searches for your query within nearby open restaurants."
        long_desc "Ask me to 'search <your_term>'!"
      end

      command "search" do |client, data, match|
        term = match[:expression]
        response = YelpService.new({term: term, limit: 8}).search
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
              color: "#12dfad"
            }
          end
        end
      end
    end
  end
end
