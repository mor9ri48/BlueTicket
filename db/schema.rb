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

ActiveRecord::Schema[7.0].define(version: 2024_01_02_042026) do
  create_table "administrators", force: :cascade do |t|
    t.string "name", null: false
    t.string "login_name", null: false
    t.string "password", null: false
    t.string "password_confimation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airlines", force: :cascade do |t|
    t.string "name", null: false
    t.string "login_name", null: false
    t.string "password", null: false
    t.string "password_confirmation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airmodels", force: :cascade do |t|
    t.string "name", null: false
    t.integer "economy_nums", null: false
    t.integer "business_nums", null: false
    t.integer "first_nums", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airports", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "alph_name", null: false
    t.string "login_name", null: false
    t.integer "sex", default: 1, null: false
    t.date "birthday", null: false
    t.string "password", null: false
    t.string "password_confirmation", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.string "name", null: false
    t.integer "airline_id", null: false
    t.integer "airmodel_id", null: false
    t.date "departure_date", null: false
    t.time "departure_time", null: false
    t.date "arrival_date", null: false
    t.time "arrival_time", null: false
    t.integer "origin_id", null: false
    t.integer "destination_id", null: false
    t.boolean "operation", default: true, null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airline_id"], name: "index_flights_on_airline_id"
    t.index ["airmodel_id"], name: "index_flights_on_airmodel_id"
    t.index ["destination_id"], name: "index_flights_on_destination_id"
    t.index ["origin_id"], name: "index_flights_on_origin_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "airmodel_id"
    t.string "number", null: false
    t.string "seat_class", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airmodel_id"], name: "index_seats_on_airmodel_id"
  end

end
