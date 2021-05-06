# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_06_203523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "email_alert_users", force: :cascade do |t|
    t.string "email", null: false
    t.boolean "confirmed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_email_alert_users_on_email", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "title", null: false
    t.string "vendor", null: false
    t.string "handle", null: false
    t.string "plant", null: false
    t.boolean "available", null: false
    t.string "strain"
    t.string "p_id", null: false
    t.boolean "p_v_default"
    t.boolean "p_v_1g"
    t.boolean "p_v_3_5g"
    t.boolean "p_v_7g"
    t.boolean "p_v_15g"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_available"
    t.datetime "last_unavailable"
    t.datetime "p_created_at"
    t.boolean "p_v_28g"
    t.index ["p_id"], name: "index_products_on_p_id", unique: true
  end

end
