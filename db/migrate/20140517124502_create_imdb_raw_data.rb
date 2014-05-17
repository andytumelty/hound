class CreateImdbRawData < ActiveRecord::Migration
  def change
    create_table :imdb_raw_data do |t|
      t.string :Title
      t.integer :Year
      t.string :Rated
      t.string :Released
      t.string :Runtime
      t.string :Genre
      t.text :Director
      t.text :Writer
      t.text :Actors
      t.text :Plot
      t.string :Language
      t.string :Country
      t.string :Awards
      t.text :Poster
      t.integer :Metascore
      t.float :imdbRating
      t.integer :imdbVotes
      t.string :imdbID
      t.string :Type
      t.float :tomatoMeter
      t.string :tomatoImage
      t.float :tomatoRating
      t.integer :tomatoReviews
      t.integer :tomatoFresh
      t.integer :tomatoRotten
      t.text :tomatoConsensus
      t.integer :tomatoUserMeter
      t.float :tomatoUserRating
      t.integer :tomatoUserReviews
      t.string :DVD
      t.string :BoxOffice
      t.string :Production
      t.string :Website
      t.text :Response

      t.timestamps
    end
  end
end
