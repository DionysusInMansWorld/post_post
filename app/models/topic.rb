class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 64 }

end
