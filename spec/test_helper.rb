def sign_up(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
  visit '/'
  click_link 'Sign up'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password_confirmation
  click_button 'Sign up'
end

def add_restaurant(name, description)
  visit '/restaurants'
  click_link('add_restaurant')
  fill_in('restaurant_name', with: name)
  fill_in('restaurant_description', with: description)
  click_on('submit')
end

def edit_restaurant(name, description)
  click_on('Edit')
  fill_in('restaurant_name', with: name)
  fill_in('restaurant_description', with: description)
  click_on('submit')
end

def rate_restaurant(rating, comment)
  click_link('Review')
  select rating, from: :review_rating
  fill_in('review_comments', with: comment)
  click_on('submit review')
end
