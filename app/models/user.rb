class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates :email, :password, :password_confirmation, :presence => true
  validates_uniqueness_of :email
  validates :password, :password_confirmation, :length => {in: 6..20}
end
