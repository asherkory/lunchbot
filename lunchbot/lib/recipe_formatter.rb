module Lunchbot
  class RecipeFormatter
    def self.format_recipe(recipe)
      {
        fallback: recipe["title"],
        title: recipe["title"],
        title_link: recipe["sourceUrl"],
        text: recipe["summary"],
        thumb_url: recipe["image"],
        color: "#12dfad"
      }
    end
  end
end
