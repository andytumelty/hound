class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :rated
      t.string :released
      t.string :runtime
      t.text :plot
      t.string :country
      t.string :awards
      t.integer :metascore
      t.float :imdb_rating
      t.integer :imdb_votes
      t.float :tomato_meter
      t.text :tomato_consensus
      t.string :wiki_title
      t.string :imdb_id
      t.string :rt_title

      t.timestamps
    end
  end
end
