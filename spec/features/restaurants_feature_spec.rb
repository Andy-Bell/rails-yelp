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
				Restaurant.create(name: 'Lupita')
			end

			scenario 'display restaurants' do
				visit '/restaurants'
				expect(page).to have_content('Lupita')
			end

	end


end
