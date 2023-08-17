require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Kay', posts_counter: 1) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).not_to be_valid
  end

  it 'post_counter should an integer' do
    subject.posts_counter = 1.2
    expect(subject).not_to be_valid
  end

  it 'should return recent_posts_for_user' do
    user = User.create!(name: 'Kay', posts_counter: 0)
    3.times.map do
      Post.create!(author: user, title: 'Old post', comments_counter: 0, likes_counter: 0, created_at: 1.day.ago)
    end
    new_posts = 3.times.map { Post.create!(author: user, title: 'New post', comments_counter: 0, likes_counter: 0) }

    expect(user.recent_posts_for_user).to eq new_posts.reverse
  end
end
