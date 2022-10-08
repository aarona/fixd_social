class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates_presence_of :title, :body, :posted_at

  def comment_count
    comments.length
  end
  
end
