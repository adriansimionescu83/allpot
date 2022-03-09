class AddFatToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :fat, :string
  end
end
