class Like < ApplicationRecord
  belongs_to :user
  belongs_to :liked, class_name: "Micropost"
  validates :post_id, presence: true
  validates :liker_id, presence: true
end
