class Recipe < ApplicationRecord
  STATUS = ["Cooked", "Uncooked"]
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :status, default: "Uncooked"
  validates :comments, length: { minimum: 2 }

end
