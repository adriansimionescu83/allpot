class AddStepsColumnToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :steps, :string, array: true, default: []
  end
end
