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

# --------------- Beverages & Liquids ---------------
  Ingredient.create(
    name: "Soy Milk",
    measure: "ml",
    category: "Beverages",
    quantity: "1000",
    user_id: 1
  )
  Ingredient.create(
    name: "Perrier",
    measure: "ml",
    category: "Beverages",
    quantity: "1000",
    user_id: 1
  )
  Ingredient.create(
    name: "Orange Juice",
    measure: "ml",
    category: "Beverages",
    quantity: "330",
    user_id: 1
  )

  Ingredient.create(
    name: "Water",
    measure: "ml",
    category: "Beverages",
    quantity: "1000",
    user_id: 1
  )

  Ingredient.create(
    name: "Stock",
    measure: "ml",
    category: "Beverages",
    quantity: "1000",
    user_id: 1
  )

# --------------- Bread & Bakery ---------------
  Ingredient.create(
    name: "Baking Powder",
    measure: "g",
    category: "Bread & Bakery",
    quantity: "100",
    user_id: 1
  )

  Ingredient.create(
    name: "Baking Soda",
    measure: "g",
    category: "Bread & Bakery",
    quantity: "100",
    user_id: 1
  )

  Ingredient.create(
    name: "Sugar",
    measure: "g",
    category: "Bread & Bakery",
    quantity: "500",
    user_id: 1
  )

  Ingredient.create(
    name: "Cornstarch",
    measure: "g",
    category: "Bread & Bakery",
    quantity: "100",
    user_id: 1
  )

  Ingredient.create(
    name: "Flour",
    measure: "g",
    category: "Bread & Bakery",
    quantity: "750",
    user_id: 1
  )

  Ingredient.create(
    name: "Honey",
    measure: "g",
    category: "Bread & Bakery",
    quantity: "300",
    user_id: 1
  )

  # --------------- Canned Food ---------------
  Ingredient.create(
    name: "Chickpeas",
    measure: "g",
    category: "Canned Food",
    quantity: "450",
    user_id: 1
  )
  Ingredient.create(
    name: "Kidney Beans",
    measure: "g",
    category: "Canned Food",
    quantity: "600",
    user_id: 1
  )

  Ingredient.create(
    name: "Capers",
    measure: "g",
    category: "Canned Food",
    quantity: "300",
    user_id: 1
  )

  Ingredient.create(
    name: "Olives",
    measure: "g",
    category: "Canned Food",
    quantity: "330",
    user_id: 1
  )

  Ingredient.create(
    name: "Peanut Butter",
    measure: "g",
    category: "Canned Food",
    quantity: "300",
    user_id: 1
  )

  Ingredient.create(
    name: "Tomato Paste",
    measure: "g",
    category: "Canned Food",
    quantity: "330",
    user_id: 1
  )


# --------------- Condiments ---------------
  Ingredient.create(
    name: "Dijon Mustard",
    measure: "g",
    category: "Condiments",
    quantity: "250",
    user_id: 1
  )
  Ingredient.create(
    name: "Ketchup",
    measure: "g",
    category: "Condiments",
    quantity: "450",
    user_id: 1
  )
  Ingredient.create(
    name: "Olive Oil",
    measure: "g",
    category: "Condiments",
    quantity: "1000",
    user_id: 1
  )
  Ingredient.create(
    name: "Canola Oil",
    measure: "g",
    category: "Condiments",
    quantity: "750",
    user_id: 1
  )
  Ingredient.create(
    name: "Mayonnaise",
    measure: "g",
    category: "Condiments",
    quantity: "300",
    user_id: 1
  )
  Ingredient.create(
    name: "Soy Sauce",
    measure: "g",
    category: "Condiments",
    quantity: "450",
    user_id: 1
  )
  Ingredient.create(
    name: "Worcestershire",
    measure: "g",
    category: "Condiments",
    quantity: "450",
    user_id: 1
  )
  Ingredient.create(
    name: "Chili Paste",
    measure: "g",
    category: "Condiments",
    quantity: "200",
    user_id: 1
  )

# --------------- Dairy & Eggs ---------------
  Ingredient.create(
    name: "Yoghurt",
    measure: "g",
    category: "Dairy & Eggs",
    quantity: "500",
    user_id: 1
  )
  Ingredient.create(
    name: "Cheddar",
    measure: "g",
    category: "Dairy & Eggs",
    quantity: "300",
    user_id: 1
  )
  Ingredient.create(
    name: "Butter",
    measure: "g",
    category: "Dairy & Eggs",
    quantity: "250",
    user_id: 1
  )
  Ingredient.create(
    name: "Feta",
    measure: "g",
    category: "Dairy & Eggs",
    quantity: "300",
    user_id: 1
  )
  Ingredient.create(
    name: "Mozzarella",
    measure: "g",
    category: "Dairy & Eggs",
    quantity: "250",
    user_id: 1
  )
  Ingredient.create(
    name: "Eggs",
    measure: "g",
    category: "Dairy & Eggs",
    quantity: "400",
    user_id: 1
  )
# --------------- Fruits ---------------
  Ingredient.create(
    name: "Apple",
    measure: "g",
    category: "Fruits",
    quantity: "500",
    user_id: 1
  )
  Ingredient.create(
    name: "Banana",
    measure: "g",
    category: "Fruits",
    quantity: "750",
    user_id: 1
  )
  Ingredient.create(
    name: "Pineapple",
    measure: "g",
    category: "Fruits",
    quantity: "300",
    user_id: 1
  )
  Ingredient.create(
    name: "Strawberries",
    measure: "g",
    category: "Fruits",
    quantity: "250",
    user_id: 1
  )
  Ingredient.create(
    name: "Dates",
    measure: "g",
    category: "Fruits",
    quantity: "400",
    user_id: 1
  )


# --------------- Grains & Pasta ---------------
  Ingredient.create(
    name: "Gluten Free Pasta",
    measure: "g",
    category: "Grains & Pasta",
    quantity: "500",
    user_id: 1
  )

  Ingredient.create(
    name: "Rice",
    measure: "g",
    category: "Grains & Pasta",
    quantity: "1000",
    user_id: 1
  )
  Ingredient.create(
    name: "Lentils",
    measure: "g",
    category: "Grains & Pasta",
    quantity: "500",
    user_id: 1
  )
  Ingredient.create(
    name: "Oats",
    measure: "g",
    category: "Grains & Pasta",
    quantity: "500",
    user_id: 1
  )
  Ingredient.create(
    name: "Quinoa",
    measure: "g",
    category: "Grains & Pasta",
    quantity: "500",
    user_id: 1
  )
  Ingredient.create(
    name: "Breadcrumbs",
    measure: "g",
    category: "Grains & Pasta",
    quantity: "500",
    user_id: 1
  )
  Ingredient.create(
    name: "Spaghetti",
    measure: "g",
    category: "Grains & Pasta",
    quantity: "500",
    user_id: 1
  )

# "Herbs & Spices",
  Ingredient.create(
    name: "Parsley",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "150",
    user_id: 1
  )
  Ingredient.create(
    name: "Cinnamon",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "100",
    user_id: 1
  )
  Ingredient.create(
    name: "Coriander",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "100",
    user_id: 1
  )
  Ingredient.create(
    name: "Cumin",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "50",
    user_id: 1
  )
  Ingredient.create(
    name: "Basil",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "150",
    user_id: 1
  )
  Ingredient.create(
    name: "Salt",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "300",
    user_id: 1
  )
  Ingredient.create(
    name: "Black Pepper",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "300",
    user_id: 1
  )
  Ingredient.create(
    name: "Red Chili Flakes",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "150",
    user_id: 1
  )
  Ingredient.create(
    name: "Curry Powder",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "150",
    user_id: 1
  )
  Ingredient.create(
    name: "Ground Ginger",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "150",
    user_id: 1
  )
  Ingredient.create(
    name: "Paprika",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "150",
    user_id: 1
  )
  Ingredient.create(
    name: "Oregano",
    measure: "g",
    category: "Herbs & Spices",
    quantity: "150",
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

  Ingredient.create(
    name: "Salmon",
    measure: "g",
    category: "Meat & Seafood",
    quantity: "500",
    user_id: 1
  )

  Ingredient.create(
    name: "Minced Meat",
    measure: "g",
    category: "Meat & Seafood",
    quantity: "400",
    user_id: 1
  )

# "Misc"
  Ingredient.create(
    name: "Digestive Biscuits",
    measure: "g",
    category: "Misc",
    quantity: "350",
    user_id: 1
  )

# "Nuts & Seeds"
  Ingredient.create(
    name: "Almonds",
    measure: "g",
    category: "Nuts & Seeds",
    quantity: "350",
    user_id: 1
  )
  Ingredient.create(
    name: "Peanuts",
    measure: "g",
    category: "Nuts & Seeds",
    quantity: "200",
    user_id: 1
  )
  Ingredient.create(
    name: "Sunflower Seeds",
    measure: "g",
    category: "Nuts & Seeds",
    quantity: "250",
    user_id: 1
  )
  Ingredient.create(
    name: "Flax Seeds",
    measure: "g",
    category: "Nuts & Seeds",
    quantity: "350",
    user_id: 1
  )
  Ingredient.create(
    name: "Pine Nuts",
    measure: "g",
    category: "Nuts & Seeds",
    quantity: "350",
    user_id: 1
  )

# "Vegetables"
  Ingredient.create(
    name: "Broccoli",
    measure: "g",
    category: "Vegetables",
    quantity: "1000",
    user_id: 1
  )

  Ingredient.create(
    name: "Tomato",
    measure: "g",
    category: "Vegetables",
    quantity: "250",
    user_id: 1
  )

  Ingredient.create(
    name: "Cucumber",
    measure: "g",
    category: "Vegetables",
    quantity: "500",
    user_id: 1
  )

  Ingredient.create(
    name: "Sweet Potato",
    measure: "g",
    category: "Vegetables",
    quantity: "750",
    user_id: 1
  )

  Ingredient.create(
    name: "Asparagus",
    measure: "g",
    category: "Vegetables",
    quantity: "300",
    user_id: 1
  )

  Ingredient.create(
    name: "Avocado",
    measure: "g",
    category: "Vegetables",
    quantity: "400",
    user_id: 1
  )

  Ingredient.create(
    name: "Garlic",
    measure: "g",
    category: "Vegetables",
    quantity: "200",
    user_id: 1
  )

  Ingredient.create(
    name: "Onion",
    measure: "g",
    category: "Vegetables",
    quantity: "600",
    user_id: 1
  )

  Ingredient.create(
    name: "Lemon",
    measure: "g",
    category: "Vegetables",
    quantity: "500",
    user_id: 1
  )

  Ingredient.create(
    name: "Bell Peppers",
    measure: "g",
    category: "Vegetables",
    quantity: "400",
    user_id: 1
  )
  Ingredient.create(
    name: "Lemon",
    measure: "g",
    category: "Vegetables",
    quantity: "500",
    user_id: 1
  )

puts "All ingredients now seeded"
