module Lunchbot
  module Commands
    class Lunch < SlackRubyBot::Commands::Base

      help do
        title "lunch"
        desc "Tells you about food trucks and CIC lunch vendors for today or tomorrow."
        long_desc "Ask me about 'lunch today' or 'lunch tomorrow'!"
      end

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

      FARMERS_MARKETS = {
        3 => "next to Chipotle",
        4 => "next to Commonwealth"
      }

      FOOD_TRUCK_DATES = Range.new(Date.new(2018, 4, 2), Date.new(2018, 11, 16))
      FARMERS_MARKET_DATES = Range.new(Date.new(2018, 6, 1), Date.new(2018, 9, 30))

      match /lunch\s(today|tomorrow)/ do |client, data, match|
        if match[1] == "today"
          day = Date.today.wday
        elsif match[1] == "tomorrow"
          day = Date.today.next.wday
        end
        
        client.say(channel: data.channel, text: lunch_for_the_day(day))
      end

      def self.lunch_for_the_day(day)
        if day == 6 || day == 7
          "It's the weekend. Cook your own lunch!"
        else
          kitchen_vendor = KITCHEN_VENDORS[day]
          food_trucks = FOOD_TRUCKS[day]
          farmers_market = FARMERS_MARKETS[day]

          str = "CIC 4th floor vendor: #{kitchen_vendor}. "
          str += "Food trucks at 3rd St: #{food_trucks.join(", ")}." if FOOD_TRUCK_DATES.include?(Date.today)
          str += "Farmers' market: #{farmers_market}" if farmers_market && FARMERS_MARKET_DATES.include?(Date.today)
        end
      end
    end
  end
end