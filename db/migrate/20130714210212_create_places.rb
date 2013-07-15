class CreatePlaces < ActiveRecord::Migration
  def up
    create_table :places do |t|
      t.text :rating_img_url
      t.string :country_code
      t.string :id
      t.boolean :is_closed
      t.string :city
      t.string :mobile_url
      t.integer :review_count
      t.string :zip
      t.string :state
      t.text :rating_img_url_small
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :phone
      t.string :state_code
      t.text :categories
      t.text :photo_url
      t.float :distance
      t.string :name
      t.text :neighborhoods
      t.text :url
      t.string :country
      t.float :avg_rating
      t.text :nearby_url
      t.text :reviews
      t.text :photo_url_smal
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.belongs_to :users
      t.timestamps
    end
  end

  def down
    drop_table :places
  end
end
