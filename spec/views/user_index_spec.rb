require 'rails_helper'

RSpec.describe 'Users', type: :system do
  fixtures :users
  let(:user1) { users(:one) }
  let(:user2) { users(:two) }
  let(:user3) { users(:three) }
  describe 'index page' do
    it 'should show the username of all the users' do
      visit users_path
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user2.name)
      expect(page).to have_content(user3.name)
    end
    it 'should show the profile picture for each user.' do
      visit users_path
      expect(page).to have_selector("img[src='#{user1.photo}']")
      expect(page).to have_selector("img[src='#{user2.photo}']")
      expect(page).to have_selector("img[src='#{user3.photo}']")
    end

    it 'should see the number of posts each user has written.' do
      visit users_path
      expect(page).to have_content(user1.posts_counter)
      expect(page).to have_content(user2.posts_counter)
      expect(page).to have_content(user3.posts_counter)
    end
    it "When I click on a user, I am redirected to that user's show page" do
      user = users(:one)
      visit users_path
      expect(page).to have_link(user.name, href: user_path(user))
      click_link user.name
      expect(current_path).to eq('/users' || user_path(user))
    end
  end
end
