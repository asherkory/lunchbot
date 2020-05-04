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
        2 => "Dumpling Daughter",
        3 => "Dates & Olives",
        4 => "Tenoch Mexican",
        5 => "Shabu & Mein",
      }

      FOOD_TRUCKS = {
        1 => ["Gogi on the Block", "The Bacon Truck"],
        2 => ["Bartleby's Seitan Stand", "Teri-Yummy"],
        3 => ["Coconut Louise", "Kebabish"],
        4 => ["Roadies", "Sa Pa Vietnamese Kitchen"],
        5 => ["Da Bomb Truck", "Rhythym and Wraps"]
      }

      FARMERS_MARKETS = {
        3 => {
          place: "next to Chipotle",
          dates: Range.new(Date.new(2019, 5, 16), Date.new(2019, 10, 31))
        },
        4 => {
          place: "next to Commonwealth",
          dates: Range.new(Date.new(2019, 6, 7), Date.new(2019, 9, 27))
        }
      }

      FOOD_TRUCK_DATES = Range.new(Date.new(2019, 3, 25), Date.new(2019, 11, 29))

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

          str = "🏢 CIC 4th floor vendor: #{kitchen_vendor}. "
          str += "\n🚚 Food trucks at 3rd St: #{food_trucks.join(", ")}. " if FOOD_TRUCK_DATES.include?(Date.today)
          str += "\n🌾 Farmers' market: #{farmers_market[:place]}." if farmers_market && farmers_market[:dates].include?(Date.today)
          str
        end
      end
    end
  end
end
