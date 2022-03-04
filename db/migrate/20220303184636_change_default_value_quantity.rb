class ChangeDefaultValueQuantity < ActiveRecord::Migration[6.1]
  def change
    change_column_default :ingredients, :quantity, from: 0.0, to: nil
  end
end
