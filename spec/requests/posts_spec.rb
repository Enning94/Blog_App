require 'rails_helper'

RSpec.describe "Posts", type: :request do
    before do
        @user = User.create(name: 'Microverse', photo: 'photo_url', bio: 'Rails Developer', posts_counter: 0)
        @post = Post.create(author: @user, title: 'Controller spec', text: 'Testing controllers using Rspec', comments_counter: 0,
            likes_counter: 0)  
    end
  describe "GET posts_controller actions" do
    it " should check index action" do
      get user_posts_path(user_id: @user.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include("Display a list of all posts for a specific user")
    end

    it "should check show action" do
    get user_post_path(id: @post.id, user_id: @user.id)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)
    expect(response.body).to include("Display a specific post belonging to a specific user")
    end 
  end
end

