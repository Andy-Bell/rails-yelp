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

    context 'Lupita restaurant' do
      before(:each) do
        visit '/restaurants'
        click_link('Lupita')
      end

      scenario 'delete a restaurant' do
        expect(page).to have_content('Lupita')
        click_on('Delete')
        expect(page).not_to have_content('Lupita')
      end

      scenario 'edit details' do
        expect(page).to have_content('Mexican')
        edit_restaurant('Lupita', 'High quality mexican food')
        expect(page).to have_content 'High quality mexican food'
      end

      scenario 'rate a restaurant' do
        rate_restaurant(4, 'Tasty food')
        expect(page).to have_content('Tasty food')
        expect(page).to have_content('Average Rating: 4')
      end

    end

    scenario 'unable to rate own restaurant' do
      sign_up
      visit '/restaurants'
      click_link('add_restaurant')
      add_restaurant('Gaucho', 'Fabulous steak')
      click_link('Gaucho')
      rate_restaurant(4, 'Just the best Argentinian steak')
      expect(page).not_to have_content('Just the best Argentinian steak')
      expect(page).to have_content('error')
    end

  end

  context 'restaurant creation' do
    scenario 'allows creation of restaurant' do
      add_restaurant('Pizza Express','Makes pizza and pasta')
      expect(page).to have_content('Pizza Express')
      expect(page).to have_content('Makes pizza and pasta')
    end

    context 'add an invalid restaurant' do
      scenario 'it does not let you submit a name that is too short' do
        add_restaurant('KF', 'Fried chicken')
        expect(page).not_to have_content('KF')
        expect(page).to have_content('error')
      end
    end
  end


end
