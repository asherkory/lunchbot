module Lunchbot
  class RecipeFormatter
    def self.format_recipe(recipe)
      text = SlackTransformer::Html.new(recipe["summary"]).to_slack
      {
        mrkdwn_in: ["text"],
        fallback: recipe["title"],
        title: recipe["title"],
        title_link: recipe["sourceUrl"],
        text: text,
        thumb_url: recipe["image"],
        color: "#12dfad"
      }
    end
  end
end
