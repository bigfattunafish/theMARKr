class JoinPlacesLists < ActiveRecord::Migration
  def up
    create_table :lists_places, id: false do |t|
      t.belongs_to :list
      t.belongs_to :place
    end
  end

  def down
    drop_table :lists_places
  end
end
