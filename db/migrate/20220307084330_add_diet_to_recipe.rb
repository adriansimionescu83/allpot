class AddDietToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :diets, :string, array: true, default: []
  end
end
