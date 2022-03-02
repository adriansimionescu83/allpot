class AddNewColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :call_api_recipes, :boolean, default: true
  end
end
