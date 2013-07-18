# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130717053214) do

  create_table "lists", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lists_places", :id => false, :force => true do |t|
    t.integer "list_id"
    t.integer "place_id"
  end

  create_table "places", :force => true do |t|
    t.boolean  "is_claimed"
    t.float    "rating"
    t.text     "mobile_url"
    t.text     "rating_img_url"
    t.integer  "review_count"
    t.string   "name"
    t.text     "snippet_image_url"
    t.text     "rating_img_url_small"
    t.text     "url"
    t.string   "phone"
    t.text     "snippet_text"
    t.text     "image_url"
    t.text     "categories"
    t.string   "display_phone"
    t.text     "rating_img_url_large"
    t.string   "yelp_id"
    t.boolean  "is_closed"
    t.text     "location"
    t.text     "tags"
    t.text     "tags_display"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "user_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
