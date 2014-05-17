class CreateMovieGenreJoinTable < ActiveRecord::Migration
  def change
    create_join_table :movies, :genres do |t|
      # t.index [:movie_id, :genre_id]
      t.index [:genre_id, :movie_id], unique: true
    end
  end
end
