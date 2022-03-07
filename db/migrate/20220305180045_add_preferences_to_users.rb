class AddPreferencesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :diet, :string, array: true, default: []
    add_column :users, :intolerances, :string, array: true, default: []
  end
end
