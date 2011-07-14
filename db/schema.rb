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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110714075613) do

  create_table "locations", :force => true do |t|
    t.decimal  "lat",        :null => false
    t.decimal  "lng",        :null => false
    t.text     "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["name"], :name => "index_locations_on_name"

  create_table "routes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.date     "discontinued"
  end

  create_table "stops", :force => true do |t|
    t.integer "routes_id"
    t.text    "name",         :null => false
    t.boolean "pass_through"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
