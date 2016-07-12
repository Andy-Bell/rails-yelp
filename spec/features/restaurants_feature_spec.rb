require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_link('add_restaurant')
    end

    scenario 'should take to a page to add a new restaurant' do
      visit '/restaurants'
      click_link('add_restaurant')
      expect(page).to have_content('Create a Restaurant')
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Lupita', description: 'Mexican')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Lupita')
    end

    scenario 'delete a restaurant' do
      visit '/restaurants'
      click_link('Lupita')
      expect(page).to have_content('Lupita')
      click_on('Delete')
      expect(page).not_to have_content('Lupita')
    end

    scenario 'edit details' do
      visit '/restaurants'
      click_link('Lupita')
      expect(page).to have_content('Mexican')
      click_on('Edit')
      fill_in('restaurant_description', with: 'High quality mexican food')
      click_on('submit')
      expect(page).to have_content 'High quality mexican food'
    end

    scenario 'rate a restaurant' do
      visit '/restaurants'
      click_link('Lupita')
      click_link('Review')
      select '4', from: :review_rating
      fill_in('review_comments', with: 'Tasty food')
      click_on('submit review')
      expect(page).to have_content('Tasty food')
      expect(page).to have_content('Average Rating: 4')
    end

  end

  context 'restaurant creation' do
    scenario 'allows creation of restaurant' do
      visit '/restaurants'
      click_link('add_restaurant')
      fill_in('restaurant_name', with: 'Pizza Express')
      fill_in('restaurant_description', with: 'Makes pizza and pasta')
      click_on('submit')
      expect(page).to have_content('Pizza Express')
      expect(page).to have_content('Makes pizza and pasta')
    end
  end


end
