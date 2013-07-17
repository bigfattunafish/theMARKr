class CreateLists < ActiveRecord::Migration
  def up
    create_table :lists do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :lists
  end
end