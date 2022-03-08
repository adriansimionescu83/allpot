class AddAttributesToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :protein, :string
    add_column :recipes, :carbs, :string
  end
end
