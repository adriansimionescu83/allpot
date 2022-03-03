class Ingredient < ApplicationRecord
  UNITS = ['g', 'ml']
  CATEGORY = [
    "Beverages",
    "Bread & Bakery",
    "Canned Food",
    "Condiments",
    "Dairy & Eggs",
    "Herbs & Spices",
    "Fruits",
    "Grains & Pasta",
    "Meat & Seafood",
    "Misc",
    "Vegetables"
  ]

  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, length: { in: 2..50 }
  validates :quantity, presence: true, inclusion: { in: 1..10000,
             message: "%{value} is not a valid quantity" }
  validates :measure, presence: true
  validates :category, presence: true
end
