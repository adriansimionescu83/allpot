class AddColumnsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :title, :string
    add_column :recipes, :description, :string
    add_column :recipes, :image_url, :string
    add_column :recipes, :missed_ingredients_count, :integer, default: 0
    add_column :recipes, :used_ingredients_count, :integer, default: 0
    add_column :recipes, :unused_ingredients_count, :integer, default: 0
    add_column :recipes, :missed_ingredients, :string, array: true, default: []
    add_column :recipes, :unused_ingredients, :string, array: true, default: []
  end
end
