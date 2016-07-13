def sign_up(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
  visit '/'
  click_link 'Sign up'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password_confirmation
  click_button 'Sign up'
end
