class AddCaloriesToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :calories, :string
    add_column :recipes, :protein, :string
    add_column :recipes, :carbs, :string
    add_column :recipes, :fat, :string
  end
end
