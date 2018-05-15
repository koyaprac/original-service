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

ActiveRecord::Schema.define(version: 20180515132128) do

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url"
    t.string   "title"
    t.string   "image_url"
    t.datetime "date"
    t.string   "site_name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "is_hold",    default: true, null: false
    t.index ["title", "date", "url", "site_name"], name: "index_articles_on_title_and_date_and_url_and_site_name", using: :btree
  end

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url"
    t.string   "title"
    t.string   "image_url"
    t.string   "salesdate"
    t.integer  "itemprice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_books_on_title", using: :btree
  end

  create_table "user_art_connect", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.string   "type"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["article_id"], name: "index_user_art_connect_on_article_id", using: :btree
    t.index ["user_id", "article_id", "type"], name: "index_user_art_connect_on_user_id_and_article_id_and_type", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_art_connect_on_user_id", using: :btree
  end

  create_table "user_art_connects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.string   "type"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["article_id"], name: "index_user_art_connects_on_article_id", using: :btree
    t.index ["user_id"], name: "index_user_art_connects_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "user_art_connects", "articles"
  add_foreign_key "user_art_connects", "users"
end
