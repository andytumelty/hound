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

ActiveRecord::Schema.define(version: 20140620220758) do

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

  create_table "imdb_raw_movies", force: true do |t|
    t.string   "Title"
    t.integer  "Year"
    t.string   "Rated"
    t.string   "Released"
    t.string   "Runtime"
    t.string   "Genre"
    t.text     "Director"
    t.text     "Writer"
    t.text     "Actors"
    t.text     "Plot"
    t.string   "Language"
    t.string   "Country"
    t.string   "Awards"
    t.text     "Poster"
    t.integer  "Metascore"
    t.float    "imdbRating"
    t.integer  "imdbVotes"
    t.string   "imdbID"
    t.string   "Type"
    t.float    "tomatoMeter"
    t.string   "tomatoImage"
    t.float    "tomatoRating"
    t.integer  "tomatoReviews"
    t.integer  "tomatoFresh"
    t.integer  "tomatoRotten"
    t.text     "tomatoConsensus"
    t.integer  "tomatoUserMeter"
    t.float    "tomatoUserRating"
    t.integer  "tomatoUserReviews"
    t.string   "DVD"
    t.string   "BoxOffice"
    t.string   "Production"
    t.string   "Website"
    t.text     "Response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "image_name"
  end

  create_table "movies_writers", id: false, force: true do |t|
    t.integer "movie_id",  null: false
    t.integer "writer_id", null: false
  end

  add_index "movies_writers", ["writer_id", "movie_id"], name: "index_movies_writers_on_writer_id_and_movie_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                           null: false
    t.string   "crypted_password",                                null: false
    t.string   "salt",                                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "auth_token",                                      null: false
    t.boolean  "is_admin",                        default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  create_table "writers", force: true do |t|
    t.string   "writer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
