class RenameImdbRawDataToImdbRawMovies < ActiveRecord::Migration
  def change
    rename_table :imdb_raw_data, :imdb_raw_movies
  end
end
