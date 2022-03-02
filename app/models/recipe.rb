class Recipe < ApplicationRecord
  STATUS = ["cooked", "uncooked"]
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

end
