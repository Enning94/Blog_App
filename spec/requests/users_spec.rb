require 'rails_helper'

RSpec.describe "Users", type: :request do
    before do
        @user = User.create(name: 'James', photo: 'photo_url', bio: 'Rails Developer', posts_counter: 0)
      end
  describe "GET users_controller actions" do
    it " should check index action" do
      get users_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include("Display a list of all users")
    end

    it "should check show action" do
    get user_path(id: @user.id)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)
    expect(response.body).to include("Display a specific user")
    end 
  end
end

