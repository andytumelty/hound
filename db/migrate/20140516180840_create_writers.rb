class CreateWriters < ActiveRecord::Migration
  def change
    create_table :writers do |t|
      t.string :writer

      t.timestamps
    end
  end
end
