class CreateCounts < ActiveRecord::Migration
  def change
    create_table :counts do |t|
      t.integer :count, :null => false
      t.datetime :refresh_time, :null => false

      t.timestamps null: false
    end
  end
end
