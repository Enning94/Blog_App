class Post < ApplicationRecord
    belongs_to :author, class_name: 'User'
    has_many :comments
    has_many :likes

    after_create :update_user_posts_counter

    def update_user_posts_counter
        return unless author.present?
  author.update(posts_counter: author.posts_counter.to_i + 1)
    end

    def recent_comments_for_post
        comments.order(created_at: :desc).limit(5)
    end
end

