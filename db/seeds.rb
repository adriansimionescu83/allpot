# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



new_recipe = Recipe.new(
  api_recipe_reference: '123456',
  # status: 'uncooked',
  user_id: 1,
  comments: 'This recipe was very good',
  title: 'Falafel sandwich'
  # image_url: recipe["image"],
  # missed_ingredients_count: recipe["missedIngredientCount"],
  # used_ingredients_count: recipe["usedIngredientCount"],
  # unused_ingredients_count: recipe["unusedIngredientCount"],
  )
  new_recipe.save!
