class AddCaloriesToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :calories, :string
  end
end
