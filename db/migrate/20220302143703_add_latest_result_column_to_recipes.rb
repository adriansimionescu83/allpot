class AddLatestResultColumnToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :is_latest_result, :boolean, default: true
  end
end
