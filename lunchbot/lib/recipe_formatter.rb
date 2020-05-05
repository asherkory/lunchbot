module Lunchbot
  class RecipeFormatter
    def self.format_recipe(recipe)
      mrkdwn_text = SlackTransformer::Html.new(recipe["summary"]).to_slack
      trimmed_text = mrkdwn_text.slice(0, 450).concat("...")
      {
        mrkdwn_in: ["text"],
        fallback: recipe["title"],
        title: recipe["title"],
        title_link: recipe["sourceUrl"],
        text: trimmed_text,
        thumb_url: recipe["image"],
        color: "#12dfad"
      }
    end
  end
end
