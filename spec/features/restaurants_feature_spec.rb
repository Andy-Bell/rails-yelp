require 'rails_helper'

feature 'restaurants' do
  let!(:lupita_owner) do
    User.create(email: 'owner@test.com', password: 'testtest', password_confirmation: 'testtest')
  end

  let!(:reviewer) do
    User.create(email: 'reviewer@test.com', password: 'testtest', password_confirmation: 'testtest')
  end

  context 'no restaurants have been added' do
    before do
      log_in(email: 'owner@test.com')
    end

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
      log_in(email: 'reviewer@test.com', password: 'testtest')
      Restaurant.create(name: 'Lupita', description: 'Mexican', user_id: lupita_owner.id)
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
        expect(page).not_to have_content('Delete Lupita')
      end

      scenario 'edit details' do
        expect(page).to have_content('Lupita')
        expect(page).not_to have_content('Edit Lupita')
      end

    end

  end

  context 'restaurant creation' do
    before(:each) do
      log_in(email: 'owner@test.com')
    end

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
