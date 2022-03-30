class AddColumnsToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :vegetarian, :boolean, default: false
    add_column :recipes, :vegan, :boolean, default: false
    add_column :recipes, :gluten_free, :boolean, default: false
    add_column :recipes, :dairy_free, :boolean, default: false
    add_column :recipes, :ketogenic, :boolean, default: false
    add_column :recipes, :spoonacular_score, :integer, default: 0
    add_column :recipes, :credits_text, :string
    add_column :recipes, :source_name, :string
    add_column :recipes, :cuisines, :string, array: true, default: []
    add_column :recipes, :dish_types, :string, array: true, default: []
    add_column :recipes, :occasions, :string, array: true, default: []
    add_column :recipes, :spoonacular_source_url, :string
    add_column :recipes, :likes, :integer, default: 0
    add_column :recipes, :intolerances, :string, array: true, default: []
  end
end
