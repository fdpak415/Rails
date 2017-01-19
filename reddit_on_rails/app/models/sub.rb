class Sub < ApplicationRecord
  validates :title, :description, :moderator, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
  foreign_key: :user_id,
  class_name: "User",
  inverse_of: :subs

  has_many :post_subs,
  inverse_of: :sub,
  dependent: :destroy

  has_many :posts,
  through: :post_subs,
  source: :post
end
