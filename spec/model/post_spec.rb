require 'rails_helper'

RSpec.describe User, type: :model do
  # let(:user){User.new(name: 'Kay', posts_counter: 1)}
  subject { Post.new(title: 'First Post', comments_counter: 2, likes_counter: 1) }

  before { subject.save }
  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not exceed 250 characters' do
    subject.title = 'a' * 251
    expect(subject).not_to be_valid
  end

  it 'comment_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).not_to be_valid
  end

  it 'like_counter should be greater than or equal to 0' do
    subject.likes_counter = -3
    expect(subject).not_to be_valid
  end

  it 'comment_counter should an integer' do
    subject.comments_counter = 1.2
    expect(subject).not_to be_valid
  end

  it 'like_counter should an integer' do
    subject.likes_counter = 3.2
    expect(subject).not_to be_valid
  end

  it 'should update_user_posts_counter' do
    author = User.create!(name: 'Kay', posts_counter: 0)
    post = Post.new(title: 'First Post', comments_counter: 0, likes_counter: 0, author:)
    expect { post.save! }.to change { author.reload.posts_counter }.by(1)
  end

  it 'should return recent_5_comments_for_post' do
    author = User.create!(name: 'Kay', posts_counter: 0)
    post = Post.create!(title: 'First Post', comments_counter: 0, likes_counter: 0, author:)
    older_comments = 6.times.map { Comment.create!(post:, text: 'Old comment', author:) }
    recent_comment = Comment.create!(post:, text: 'Recent comment', author:)

    expect(post.recent_comments_for_post).to include(recent_comment)
    expect(post.recent_comments_for_post.length).to eq(5)
    expect(post.recent_comments_for_post).to_not include(older_comments.first)
  end
end
