class AddFavoriteToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :favorite, :boolean, default: false
  end
end
