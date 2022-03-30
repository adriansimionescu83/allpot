# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_30_095648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "measure"
    t.string "category"
    t.float "quantity"
    t.boolean "is_available", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "status"
    t.string "comments"
    t.bigint "user_id", null: false
    t.string "api_recipe_reference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.string "description"
    t.string "image_url"
    t.integer "missed_ingredients_count", default: 0
    t.integer "used_ingredients_count", default: 0
    t.integer "unused_ingredients_count", default: 0
    t.string "missed_ingredients", default: [], array: true
    t.string "unused_ingredients", default: [], array: true
    t.integer "api_record_id"
    t.integer "ready_in_minutes"
    t.integer "servings"
    t.string "summary"
    t.float "overall_score"
    t.float "health_score"
    t.boolean "is_latest_result", default: true
    t.string "used_ingredients", default: [], array: true
    t.integer "aggregate_likes"
    t.string "total_ingredients", default: [], array: true
    t.string "source_url"
    t.string "steps", default: [], array: true
    t.string "diets", default: [], array: true
    t.boolean "favorite", default: false
    t.string "fat"
    t.string "protein"
    t.string "carbs"
    t.boolean "vegetarian", default: false
    t.boolean "vegan", default: false
    t.boolean "gluten_free", default: false
    t.boolean "dairy_free", default: false
    t.boolean "ketogenic", default: false
    t.integer "spoonacular_score", default: 0
    t.string "credits_text"
    t.string "source_name"
    t.string "cuisines", default: [], array: true
    t.string "dish_types", default: [], array: true
    t.string "occasions", default: [], array: true
    t.string "spoonacular_source_url"
    t.integer "likes", default: 0
    t.string "intolerances", default: [], array: true
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "call_api_recipes", default: true
    t.string "diet", default: [], array: true
    t.string "intolerances", default: [], array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ingredients", "users"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipes", "users"
end
