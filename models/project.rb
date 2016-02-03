class Project < ActiveRecord::Base
  mount_uploader :picture, Uploader
  belongs_to :user
  validates :name, :user_id, presence: true
  default_scope { order(created_at: :desc) }
  has_many :tasks, dependent: :delete_all
end
# Project.connection