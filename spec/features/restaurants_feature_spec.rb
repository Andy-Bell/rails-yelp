require 'rails_helper'

feature 'restaurants' do
	context 'no restaurants have been added' do
		scenario 'should display a prompt to add a restaurant' do
			visit '/restaurants/index'
			expect(page).to have_link('add_restaurant')
		end

    scenario 'should take to a page to add a new restaurant' do
      visit '/restaurants/index'
      click_link('add_restaurant')
      expect(page).to have_content('Create a Restaurant')
    end
	end
end
