class AddApiColumnsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :api_record_id, :integer
    add_column :recipes, :ready_in_minutes, :integer
    add_column :recipes, :servings, :integer
    add_column :recipes, :summary, :string
    add_column :recipes, :overall_score, :float
    add_column :recipes, :health_score, :float
  end
end
