class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, :project_id, presence: true
  default_scope { order(index: :asc, created_at: :desc) }
  has_one :user, through: :project
  enum priority: [:hard,:middle,:easy]
 
  def self.order_by_ids(ids)
    order_by = ["case"]
    ids.each_with_index.map do |id, index|
      order_by << "WHEN id='#{id}' THEN #{index}"
    end
    order_by << "end"
    reorder(order_by.join(" "))
  end
end
# Task.connection