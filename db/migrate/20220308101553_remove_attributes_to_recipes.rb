class RemoveAttributesToRecipes < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :protein, :string
    remove_column :recipes, :carbs, :string
    remove_column :recipes, :fat, :string
    remove_column :recipes, :calories, :string
  end
end
