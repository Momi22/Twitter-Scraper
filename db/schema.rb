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

ActiveRecord::Schema.define(version: 2021_10_04_095701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "limitations", force: :cascade do |t|
    t.string "identifier"
    t.integer "maximum_resend", default: 0
    t.integer "maximum_try", default: 0
    t.datetime "resend_at"
    t.datetime "try_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier"], name: "index_limitations_on_identifier"
  end

  create_table "twitter_scrapers", force: :cascade do |t|
    t.bigint "ref_id", null: false
    t.text "text", null: false
    t.string "screen_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
