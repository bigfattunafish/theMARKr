class User < ActiveRecord::Base
  # attr_accessible :title, :mpaa_rating, :plot, :year, :poster

  has_many :places

end
