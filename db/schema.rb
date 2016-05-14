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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160317214012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_shelves", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_shelves", ["book_id"], name: "index_book_shelves_on_book_id", using: :btree
  add_index "book_shelves", ["user_id"], name: "index_book_shelves_on_user_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "isbn"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "author_id"
    t.integer  "year"
    t.text     "description"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_friend_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "friendships", ["user_friend_id"], name: "index_friendships_on_user_friend_id", using: :btree
  add_index "friendships", ["user_id", "user_friend_id"], name: "index_friendships_on_user_id_and_user_friend_id", unique: true, using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "book_id"
  end

  add_index "messages", ["book_id"], name: "index_messages_on_book_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["message_id"], name: "index_posts_on_message_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "book_shelves", "books"
  add_foreign_key "book_shelves", "users"
  add_foreign_key "books", "authors"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "user_friend_id"
  add_foreign_key "messages", "books"
  add_foreign_key "messages", "users"
  add_foreign_key "posts", "messages"
  add_foreign_key "posts", "users"
end
