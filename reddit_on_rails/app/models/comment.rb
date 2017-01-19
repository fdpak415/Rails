class Comment < ApplicationRecord

  validates :content, :author, :post, presence: true

  belongs_to :post, inverse_of: :comments,
  foreign_key: :post_id,
  class_name: 'Post'

  belongs_to :author,
  class_name: "User",
  foreign_key: :user_id,
  inverse_of: :comments

  has_many :child_comments,
  foreign_key: :parent_comment_id,
  class_name: 'Comment',
  primary_key: :id

  belongs_to :parent_comment, optional: true,
  foreign_key: :parent_comment_id,
  class_name: 'Comment',
  primary_key: :id

end
