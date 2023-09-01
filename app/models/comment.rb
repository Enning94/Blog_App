class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  validates :text, presence: true
  after_save :update_comments_counter_for_post
  def update_comments_counter_for_post
    return unless post.present?

    post.update(comments_counter: post.comments_counter.to_i + 1)
  end

  def decrement_counter
    post.decrement!(:comments_counter)
  end
end
