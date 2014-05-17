class CreateMovieWriterJoinTable < ActiveRecord::Migration
  def change
    create_join_table :movies, :writers do |t|
      # t.index [:movie_id, :writer_id]
      t.index [:writer_id, :movie_id], unique: true
    end
  end
end
