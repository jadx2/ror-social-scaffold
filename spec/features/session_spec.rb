require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  let(:user) { User.new(name: 'abdul12', email: 'abdul123@gmaol.com', password: '123456') }

  def login_user(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end

  context 'User Login' do
    scenario 'successfully Login' do
      user.save
      login_user(user)
      expect(page).to have_content 'Signed in successfully.'
    end

    scenario 'Unable to Login' do
      login_user(user)
      expect(page).to have_content 'Invalid Email or password.'
    end
  end

  context 'SignUp User' do
    scenario 'Successfully Signup' do
      visit new_user_registration_path
      fill_in 'user_name', with: 'Alica'
      fill_in 'user_email', with: 'Alica@gmail.com'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'
      click_button 'Sign up'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end
  end
end
