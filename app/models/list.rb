class List < ActiveRecord::Base
  attr_accessible :name, :user_id, :place_ids

  belongs_to :user
  has_and_belongs_to_many :places

  validates :name, presence: true
end