module Lunchbot
  class RecipeFormatter
    def self.format_recipe(recipe)
      text = ReverseMarkdown.convert(recipe["summary"])
      {
        fallback: recipe["title"],
        mrkdwn_in: ["text"],
        title: recipe["title"],
        title_link: recipe["sourceUrl"],
        text: text,
        thumb_url: recipe["image"],
        color: "#12dfad"
      }
    end
  end
end
