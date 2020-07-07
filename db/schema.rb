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

ActiveRecord::Schema.define(version: 2020_07_07_205652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "profile_id"
    t.string "logradouro"
    t.string "numero"
    t.string "complemento"
    t.integer "bairro_id"
    t.index ["profile_id"], name: "index_addresses_on_profile_id"
  end

  create_table "bairros", force: :cascade do |t|
    t.string "name"
    t.float "lat"
    t.float "lng"
    t.integer "regiao"
    t.string "alias"
    t.index ["alias"], name: "index_bairros_on_alias"
    t.index ["lat", "lng"], name: "index_bairros_on_lat_and_lng"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_bookmarks_on_profile_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "categs", force: :cascade do |t|
    t.string "name"
    t.string "search_tags"
    t.integer "status", default: 0, null: false
    t.string "alias", null: false
    t.string "icon"
    t.integer "order"
    t.index ["alias"], name: "index_categs_on_alias"
    t.index ["name"], name: "index_categs_on_name"
  end

  create_table "claims", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "user_id"
    t.string "uuid"
    t.integer "status", default: 0
    t.datetime "created_at"
    t.index ["uuid"], name: "index_claims_on_uuid"
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.boolean "has_delivery", default: true
    t.boolean "has_retirada", default: false
    t.boolean "has_ponto_comercial", default: false
    t.integer "bairro_ids", default: [], array: true
  end

  create_table "features", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.boolean "delivery", default: false
    t.boolean "ponto_comercial", default: false
    t.boolean "produtor_local", default: false
    t.boolean "vegetariano", default: false
    t.boolean "natural", default: false
    t.boolean "vegano", default: false
    t.boolean "organico", default: false
    t.boolean "lactose", default: false
    t.boolean "gluten", default: false
    t.boolean "diabetico", default: false
    t.boolean "plus_size", default: false
    t.boolean "plastico", default: false
    t.boolean "restricao_etaria", default: false
    t.index ["profile_id"], name: "index_features_on_profile_id"
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

  create_table "lead_excels", force: :cascade do |t|
    t.string "instagram"
    t.string "name"
    t.string "whatsapp"
    t.string "website"
    t.string "logradouro"
    t.string "numero"
    t.string "bairro"
    t.string "horarios"
    t.string "categoria"
    t.string "porte"
  end

  create_table "lead_instagrams", force: :cascade do |t|
    t.string "instagram_user_id"
    t.string "username"
    t.string "title"
    t.string "avatar_url"
    t.datetime "created_at"
    t.index ["username"], name: "index_lead_instagrams_on_username"
  end

  create_table "lists", force: :cascade do |t|
    t.string "cover_image_url"
    t.string "title"
    t.string "subtitle"
    t.integer "profile_ids", default: [], array: true
    t.time "starts_at"
    t.time "finishes_at"
    t.datetime "expires_on"
    t.integer "priority"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "opening_hours", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "day"
    t.time "opens_at"
    t.time "closes_at"
    t.boolean "closed", default: true
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
    t.string "website"
    t.string "avatar_url"
    t.integer "sub_categ_id", default: 1, null: false
    t.string "username"
    t.integer "user_id"
    t.string "search_tags"
    t.integer "employees_qty"
    t.index ["username"], name: "index_profiles_on_username"
  end

  create_table "search_histories", force: :cascade do |t|
    t.integer "user_id"
    t.string "query"
    t.integer "result_qty"
    t.datetime "created_at"
    t.index ["query"], name: "index_search_histories_on_query"
  end

  create_table "statistics", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.integer "event", null: false
    t.datetime "created_at"
  end

  create_table "sub_categs", force: :cascade do |t|
    t.integer "categ_id", null: false
    t.string "name"
    t.string "search_tags"
    t.integer "status", default: 0, null: false
    t.string "alias", null: false
    t.index ["alias"], name: "index_sub_categs_on_alias"
    t.index ["name"], name: "index_sub_categs_on_name"
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
    t.boolean "admin", default: false
    t.datetime "last_login"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
