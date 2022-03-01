class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :measure
      t.string :category
      t.float :quantity, default: 0.00
      t.boolean :is_available, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
