class AddImageNameToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :image_name, :string
  end
end
