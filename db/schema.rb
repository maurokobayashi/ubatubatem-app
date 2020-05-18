# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_18_002724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "profile_id"
    t.string "logradouro"
    t.string "numero"
    t.string "complemento"
    t.string "bairro"
    t.index ["profile_id"], name: "index_addresses_on_profile_id"
  end

  create_table "categs", force: :cascade do |t|
    t.string "name"
    t.string "search_tags"
    t.integer "status"
    t.index ["name"], name: "index_categs_on_name"
  end

  create_table "instagram_accounts", force: :cascade do |t|
    t.integer "profile_id"
    t.string "username"
    t.string "access_token"
    t.string "instagram_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_instagram_accounts_on_profile_id"
  end

  create_table "opening_hours", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "day"
    t.time "opens_at"
    t.time "closes_at"
    t.index ["profile_id"], name: "index_opening_hours_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "title"
    t.string "tagline"
    t.text "bio"
    t.string "whatsapp"
    t.string "phone_secondary"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
