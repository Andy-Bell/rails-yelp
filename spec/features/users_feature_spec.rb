require 'rails_helper'

feature 'User sessions' do
  context 'User not signed in' do
    scenario 'sign out not displayed' do
      visit '/'
      expect(page).not_to have_link 'Sign out'
    end

    scenario 'sign in and sign up displayed' do
      visit '/'
      expect(page).to have_link 'Sign up'
      expect(page).to have_link 'Sign in'
    end
  end

  context 'User is signed in' do

    before do
      sign_up
    end

    scenario 'sign in and sign up links are not displayed' do
      visit '/'
      expect(page).not_to have_link 'Sign up'
      expect(page).not_to have_link 'Sign in'
    end

    scenario 'sign out link is displayed' do
      visit '/'
      expect(page).to have_link 'Sign out'
    end
  end
end



def sign_up(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
  visit '/'
  click_link 'Sign up'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password_confirmation
  click_button 'Sign up'
end
