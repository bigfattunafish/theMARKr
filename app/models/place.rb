class Place < ActiveRecord::Base
  # attr_accessible :title, :mpaa_rating, :plot, :year, :poster

  serialize :categories
  serialize :neighborhoods
  serialize :reviews

  acts_as_gmappable

  def gmaps4rails_address
    "#{address1}, #{city}, #{state}"
  end
end
