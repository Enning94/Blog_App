require 'rails_helper'

RSpec.feature 'Post new page', type: :feature do
    fixtures :users, :posts, :comments
    let(:user1) { users(:one) }
  before do
    visit new_user_post_path(user1)
  end

  scenario 'Displays form to create a new comments a single user' do
    sleep(1)
    expect(page).to have_content('Save Post to Database')
    expect(page).to have_content('Title')
    expect(page).to have_content('Text')
  end

  scenario 'Clicking on create post redirects to index page for posts' do
    click_button 'Create Post'
    sleep(1)
    
    expect(current_path).to eq(user_posts_path(user1))
  end
end