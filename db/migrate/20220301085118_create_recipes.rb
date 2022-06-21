class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :comments
      t.references :user, null: false, foreign_key: true
      t.string :api_recipe_reference
      t.timestamps
    end
  end
end
