class AddNewColumnsOnRecipeApiIngredients < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :used_ingredients, :string, array: true, default: []
    add_column :recipes, :aggregate_likes, :integer
    add_column :recipes, :total_ingredients, :string, array: true, default: []
    add_column :recipes, :source_url, :string
  end
end
