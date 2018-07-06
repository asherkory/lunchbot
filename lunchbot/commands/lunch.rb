require "Date"

module Lunchbot
  module Commands
    class Lunch < SlackRubyBot::Commands::Base
      KITCHEN_VENDORS = {
        1 => "Chicken & Rice Guys",
        2 => "Fuji",
        3 => "Dates & Olives",
        4 => "Tenoch Mexican",
        5 => "Shabu & Mein",
      }

      FOOD_TRUCKS = {
        1 => ["Bartlebys Food", "Chicken & Rice Guys"],
        2 => ["Chik Chak Food Truck", "Boston Burger Co"],
        3 => ["Sach Ko Asian Street Food", "Tandoor & Curry"],
        4 => ["Roadies Diner", "Cupcake City"],
        5 => ["Mr Tamole", "Da Bomb Truck", "Rice Burg"]
      }

      command "lunch" do |client, data, match|
        client.say(channel: data.channel, text: lunch_today)
      end

      def self.lunch_today
        today = Date.today.wday
        if today == 6 || today == 7
          "It's the weekend. Go home!"
        else
          kitchen_vendor = KITCHEN_VENDORS[today]
          food_trucks = FOOD_TRUCKS[today]

          "CIC 4th floor vendor: #{kitchen_vendor}. Food trucks at 3rd St: #{food_trucks.join(", ")}."
        end
      end
    end
  end
end