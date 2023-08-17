class Like < ApplicationRecord
    belongs_to :author, class_name: 'User'
    belongs_to :post

    def update_likes_counter_for_post
        return unless post.present?
        post.update(likes_counter: post.likes_counter.to_i + 1)
    end
end
