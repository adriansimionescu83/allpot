# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Ingredient.destroy_all
  puts "All ingredients were deleted"
end

if User.all.update(call_api_recipes: true)
  puts "All users have been updated to call api recipes"
end
# # --------------- Beverages & Liquids ---------------
#   Ingredient.create(
#     name: "Soy Milk",
#     measure: "ml",
#     category: "Beverages",
#     quantity: "1000",
#     user_id: 1
#   )
#   Ingredient.create(
#     name: "Perrier",
#     measure: "ml",
#     category: "Beverages",
#     quantity: "1000",
#     user_id: 1
#   )
#   Ingredient.create(
#     name: "Orange Juice",
#     measure: "ml",
#     category: "Beverages",
#     quantity: "330",
#     user_id: 1
#   )

# # --------------- Bread & Bakery ---------------
#   Ingredient.create(
#     name: "White Baguette",
#     measure: "g",
#     category: "Bread & Bakery",
#     quantity: "150",
#     user_id: 1
#   )

  # --------------- Canned Food ---------------
  Ingredient.create(
    name: "Chickpeas",
    measure: "g",
    category: "Canned Food",
    quantity: "450",
    user_id: 1
  )
#   Ingredient.create(
#     name: "Coconut Milk",
#     measure: "g",
#     category: "Canned Food",
#     quantity: "900",
#     user_id: 1
#   )

# # --------------- Condiments ---------------
#   Ingredient.create(
#     name: "Dijon Mustard",
#     measure: "g",
#     category: "Condiments",
#     quantity: "250",
#     user_id: 1
#   )
#   Ingredient.create(
#     name: "Ketchup",
#     measure: "g",
#     category: "Condiments",
#     quantity: "450",
#     user_id: 1
#   )

# # --------------- Dairy & Eggs ---------------
#   Ingredient.create(
#     name: "Yoghurt",
#     measure: "g",
#     category: "Dairy & Eggs",
#     quantity: "500",
#     user_id: 1
#   )
#   Ingredient.create(
#     name: "Cheddar",
#     measure: "g",
#     category: "Dairy & Eggs",
#     quantity: "300",
#     user_id: 1
#   )
#   Ingredient.create(
#     name: "Halloumi",
#     measure: "g",
#     category: "Dairy & Eggs",
#     quantity: "250",
#     user_id: 1
#   )
# # --------------- Fruits ---------------
#   Ingredient.create(
#     name: "Apple",
#     measure: "g",
#     category: "Fruits",
#     quantity: "500",
#     user_id: 1
#   )
#   Ingredient.create(
#     name: "Banana",
#     measure: "g",
#     category: "Fruits",
#     quantity: "750",
#     user_id: 1
#   )
#   Ingredient.create(
#     name: "Pineapple",
#     measure: "g",
#     category: "Fruits",
#     quantity: "300",
#     user_id: 1
#   )


# # --------------- Grains & Pasta ---------------
#   Ingredient.create(
#     name: "Gluten Free Pasta",
#     measure: "g",
#     category: "Grains & Pasta",
#     quantity: "500",
#     user_id: 1
#   )

  Ingredient.create(
    name: "Jasmine Rice",
    measure: "g",
    category: "Grains & Pasta",
    quantity: "1000",
    user_id: 1
  )


# --------------- Meat & Seafood ---------------
  Ingredient.create(
    name: "Chicken Breast",
    measure: "g",
    category: "Meat & Seafood",
    quantity: "1000",
    user_id: 1
  )

  User.all.update(call_api_recipes: true)


#   Ingredient.create(
#     name: "Salmon",
#     measure: "g",
#     category: "Meat & Seafood",
#     quantity: "500",
#     user_id: 1
#   )

#   Ingredient.create(
#     name: "Minced Meat",
#     measure: "g",
#     category: "Meat & Seafood",
#     quantity: "400",
#     user_id: 1
#   )

# # "Misc"
#   Ingredient.create(
#     name: "Digestive Biscuits",
#     measure: "g",
#     category: "Misc",
#     quantity: "350",
#     user_id: 1
#   )

# # "Vegetables"
#   Ingredient.create(
#     name: "Broccoli",
#     measure: "g",
#     category: "Vegetables",
#     quantity: "1000",
#     user_id: 1
#   )

#   Ingredient.create(
#     name: "Cherry tomato",
#     measure: "g",
#     category: "Vegetables",
#     quantity: "250",
#     user_id: 1
#   )

#   Ingredient.create(
#     name: "Cucumber",
#     measure: "g",
#     category: "Vegetables",
#     quantity: "500",
#     user_id: 1
#   )

#   Ingredient.create(
#     name: "Sweet Potato",
#     measure: "g",
#     category: "Vegetables",
#     quantity: "750",
#     user_id: 1
#   )

#   Ingredient.create(
#     name: "Asparagus",
#     measure: "g",
#     category: "Vegetables",
#     quantity: "300",
#     user_id: 1
#   )

#   Ingredient.create(
#     name: "Avocado",
#     measure: "g",
#     category: "Vegetables",
#     quantity: "400",
#     user_id: 1
#   )

#   Ingredient.create(
#     name: "Garlic",
#     measure: "g",
#     category: "Vegetables",
#     quantity: "200",
#     user_id: 1
#   )

#   Ingredient.create(
#     name: "Onion",
#     measure: "g",
#     category: "Vegetables",
#     quantity: "600",
#     user_id: 1
#   )

#   Ingredient.create(
#     name: "Lemon",
#     measure: "g",
#     category: "Vegetables",
#     quantity: "500",
#     user_id: 1
#   )

# puts "All ingredients now seeded"
