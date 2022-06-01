class Post < ApplicationRecord
  has_many :replies, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  default_scope -> { order(updated_at: :desc) }

  validates :user_id,  presence: true
  validates :topic_id, presence: true
  validates :content,  presence: true
  validates :title,    presence: true
end
