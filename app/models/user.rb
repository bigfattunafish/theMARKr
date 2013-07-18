class User < ActiveRecord::Base
  has_many :places

  attr_accessible :username, :email, :password, :password_confirmation

  # This might not be in the database
  attr_accessor :password
  before_save :encrypt_password

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, :length => { :minimum => 2 }
  validates :username, :length => { :maximum => 14 }
  validates_format_of :username, :with => /^[A-Za-z\d_]+$/

  validates :password, presence: true, on: :create
  validates :password, confirmation: true
  validates :password, :length => { :in => 8..12 }
  validates_format_of :password, :with => /^[A-Za-z\d_]+$/

  validates :email, presence: true
  validates :email, uniqueness: true

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
