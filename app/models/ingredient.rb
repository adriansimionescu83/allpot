class Ingredient < ApplicationRecord
  UNITS = ['grams', 'mL']
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, length: { in: 2..20 }
  validates :quantity, presence: true, inclusion: { in: 1..100000,
             message: "%{value} is not a valid quantity" }
  validates :measure, presence: true
  validates :category, presence: true
end
