module Lunchbot
  module Commands
    class HomeLunch < SlackRubyBot::Commands::Base
      # wfh lunch
      # remote lunch
      # home lunch
      # offers a random recipe?

      # might have to edit existing lunch command to avoid double matches:
      # use 'command' method instead of 'match' and pass today/tomorrow as args

      help do
      end

      command "" do |client, data, match|
      end
    end
  end
end
