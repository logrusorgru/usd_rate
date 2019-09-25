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

ActiveRecord::Schema.define(version: 2019_09_24_231806) do

  create_table "rates", force: :cascade do |t|
    t.integer "mantissa_fetched"
    t.integer "fraction_fetched"
    t.datetime "overwrite_until"
    t.integer "mantissa_overwrite"
    t.integer "fraction_overwrite"
  end

end
