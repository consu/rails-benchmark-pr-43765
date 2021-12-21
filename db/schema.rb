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

ActiveRecord::Schema.define(version: 2021_12_20_061342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "email_hmac"
    t.string "password_digest"
    t.string "reset_password_token"
    t.string "last_name"
    t.string "first_name"
    t.string "name"
    t.string "current_sign_in_ip"
    t.string "skype"
    t.string "linkedin"
    t.string "twitter"
    t.integer "failed_attempts"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "current_sign_in_at", precision: 6
    t.datetime "last_sign_in_at", precision: 6
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["email_hmac"], name: "index_users_on_email_hmac"
  end

end
