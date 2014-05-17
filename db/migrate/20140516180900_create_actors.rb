class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :actor

      t.timestamps
    end
  end
end
