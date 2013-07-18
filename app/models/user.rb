class User < ActiveRecord::Base
  attr_accessible :username

  has_many :places

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
    user_exist_boolean = User.find_by_email(email)
    if user_exist_boolean && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user_authenticate_boolean
    else
      nil
    end
  end
end
