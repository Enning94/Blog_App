class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }, on: :update
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }, on: :update

  after_save :update_user_posts_counter

  def update_user_posts_counter
    return unless author.present?

    author.update(posts_counter: author.posts_counter.to_i + 1)
  end

  def decrement_counter
    author.decrement!(:posts_counter)
  end

  def recent_comments_for_post
    comments.order(created_at: :desc).limit(5)
  end
end
