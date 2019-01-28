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

ActiveRecord::Schema.define(version: 20180906190358) do

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.integer "sex"
    t.string "email"
    t.string "phone_number"
    t.string "image_path"
    t.text "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "latests", force: :cascade do |t|
    t.integer "media_id"
    t.string "title"
    t.string "released"
    t.string "description"
    t.string "media_type"
    t.string "media_producer"
    t.string "artist_name"
    t.string "media_poster"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "musics", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "admin_id"
    t.string "title"
    t.string "artist_name", null: false
    t.string "album_title"
    t.string "description"
    t.string "genre"
    t.string "composer"
    t.string "producer"
    t.date "released"
    t.integer "download_count"
    t.string "poster_path"
    t.string "music_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_musics_on_admin_id"
    t.index ["artist_id"], name: "index_musics_on_artist_id"
    t.index ["artist_name"], name: "index_musics_on_artist_name"
  end

  create_table "news", force: :cascade do |t|
    t.integer "admin_id"
    t.string "title"
    t.string "news_file_url"
    t.date "released"
    t.string "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_news_on_admin_id"
  end

  create_table "videos", force: :cascade do |t|
    t.integer "admin_id"
    t.string "title"
    t.string "description"
    t.string "producer"
    t.date "released"
    t.string "video_path"
    t.string "poster_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_videos_on_admin_id"
  end

end
