class CreateMovieActorJoinTable < ActiveRecord::Migration
  def change
    create_join_table :movies, :actors do |t|
      # t.index [:movie_id, :actor_id]
      t.index [:actor_id, :movie_id], unique: true
    end
  end
end
