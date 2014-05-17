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

ActiveRecord::Schema.define(version: 20140517114047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: true do |t|
    t.string   "actor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors_movies", id: false, force: true do |t|
    t.integer "movie_id", null: false
    t.integer "actor_id", null: false
  end

  add_index "actors_movies", ["actor_id", "movie_id"], name: "index_actors_movies_on_actor_id_and_movie_id", unique: true, using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "directors", force: true do |t|
    t.string   "director"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directors_movies", id: false, force: true do |t|
    t.integer "movie_id",    null: false
    t.integer "director_id", null: false
  end

  add_index "directors_movies", ["director_id", "movie_id"], name: "index_directors_movies_on_director_id_and_movie_id", unique: true, using: :btree

  create_table "genres", force: true do |t|
    t.string   "genre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres_movies", id: false, force: true do |t|
    t.integer "movie_id", null: false
    t.integer "genre_id", null: false
  end

  add_index "genres_movies", ["genre_id", "movie_id"], name: "index_genres_movies_on_genre_id_and_movie_id", unique: true, using: :btree

  create_table "movies", force: true do |t|
    t.string   "title"
    t.integer  "year"
    t.string   "rated"
    t.string   "released"
    t.string   "runtime"
    t.text     "plot"
    t.string   "country"
    t.string   "awards"
    t.integer  "metascore"
    t.float    "imdb_rating"
    t.integer  "imdb_votes"
    t.float    "tomato_meter"
    t.text     "tomato_consensus"
    t.string   "wiki_title"
    t.string   "imdb_id"
    t.string   "rt_title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies_writers", id: false, force: true do |t|
    t.integer "movie_id",  null: false
    t.integer "writer_id", null: false
  end

  add_index "movies_writers", ["writer_id", "movie_id"], name: "index_movies_writers_on_writer_id_and_movie_id", unique: true, using: :btree

  create_table "writers", force: true do |t|
    t.string   "writer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
