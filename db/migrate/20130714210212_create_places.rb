class CreatePlaces < ActiveRecord::Migration
  def up
    create_table :places do |t|
      t.boolean :is_claimed
      t.float :rating
      t.text :mobile_url
      t.text :rating_img_url
      t.integer :review_count
      t.string :name
      t.text :snippet_image_url
      t.text :rating_img_url_small
      t.text :url
      t.string :phone
      t.text :snippet_text
      t.text :image_url
      t.text :categories
      t.string :display_phone
      t.text :rating_img_url_large
      t.string :yelp_id
      t.boolean :is_closed
      t.text :location
      t.text :tags
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.belongs_to :user
      t.timestamps
    end
  end

  def down
    drop_table :places
  end
end
