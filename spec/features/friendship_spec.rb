require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  let(:user1) { User.new(id: 1, name: 'abdul12', email: 'abdul123@gmaol.com', password: '123456') }
  let(:user2) { User.new(id: 2, name: 'jaim12', email: 'jaim12@gmaol.com', password: '123456') }

  def login_user(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end

  context 'friendship invitation' do
    scenario 'user sends invitation' do
      user1.save
      user2.save
      login_user(user1)
      visit users_path
      click_on 'Send friend request'
      expect(page).to have_content 'Pending Acceptance'
    end
  end
end
