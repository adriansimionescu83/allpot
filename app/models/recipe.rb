class Recipe < ApplicationRecord
  STATUS = ["cooked", "uncooked"]
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  include PgSearch::Model
  pg_search_scope :global_search,
    against: %i[title summary total_ingredients],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
