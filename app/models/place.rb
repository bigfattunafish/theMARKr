class Place < ActiveRecord::Base
  attr_accessible :is_claimed, :rating, :mobile_url, :rating_img_url, :review_count,
                  :name, :snippet_image_url, :rating_img_url_small, :url, :phone,
                  :snippet_text, :image_url, :categories, :display_phone, :rating_img_url_large,
                  :yelp_id, :is_closed, :location, :tags, :latitude, :longitude, :gmaps, :user

  belongs_to :users

  serialize :categories
  serialize :location
  serialize :tags

  acts_as_gmappable

  def gmaps4rails_address
    "#{location["address"].join(" ")}, #{location["display_address"][-1]}"
  end
end


