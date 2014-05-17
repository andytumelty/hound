class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :director

      t.timestamps
    end
  end
end
