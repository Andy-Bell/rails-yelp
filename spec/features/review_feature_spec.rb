feature 'restaurants review' do

	let!(:owner) do
    User.create(email: 'owner@test.com', password: 'testtest', password_confirmation: 'testtest')
  end

  let!(:reviewer) do
    User.create(email: 'reviewer@test.com', password: 'testtest', password_confirmation: 'testtest')
  end

	let!(:restaurant) do
		Restaurant.create(name: 'KFC', description: 'Delicious', user_id: owner.id)
	end


	scenario 'reviewers\' email is shown' do
		log_in(email: 'reviewer@test.com')
		click_link 'KFC'
		click_link 'Review KFC'
		select '1', from: :review_rating
		fill_in('review_comments', with: 'disgusting')
		click_on('submit review')
		within'ul#reviews' do
			expect(page).to have_content('reviewer@test.com')
		end
	end


  scenario 'unable to rate own restaurant' do
		log_in(email: 'owner@test.com')
    visit '/restaurants'
    click_link('add_restaurant')
    add_restaurant('Gaucho', 'Fabulous steak')
    click_link('Gaucho')
    expect(page).not_to have_link('Review Gaucho')
  end

end
