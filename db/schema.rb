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

ActiveRecord::Schema.define(version: 2021_09_10_100932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "guest_id", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "nights", null: false
    t.integer "total_guests", null: false
    t.json "guest_details"
    t.string "currency", null: false
    t.string "status", null: false
    t.decimal "payout_price", null: false
    t.decimal "security_price", null: false
    t.decimal "total_price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
  end

  add_foreign_key "reservations", "guests"
end
