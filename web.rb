require "sinatra/base"

module Lunchbot
  class Web < Sinatra::Base
    get "/" do
      "Is it lunchtime yet?"
    end
  end
end