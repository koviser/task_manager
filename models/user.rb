class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, confirmation: true, length: { minimum: 8, maximum: 40 }
  has_secure_password
  has_many :projects, dependent: :delete_all
end
# User.connection