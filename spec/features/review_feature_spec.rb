feature 'restaurants review' do

	let!(:restaurant) do
	   Restaurant.create(name: 'KFC', description: 'Delicious', id: 30)
	end

	scenario 'reviewers\' email is shown' do
		sign_up
		click_link 'KFC'
		click_link 'Review KFC'
		select '1', from: :review_rating
		fill_in('review_comments', with: 'disgusting')
		click_on('submit review')
		within'ul#reviews' do
			expect(page).to have_content('test@test.com')
		end
	end

  scenario 'average rating is displayed' do
    sign_up
    click_link 'KFC'
    rate_restaurant(4, 'Food was fine')
    click_link('Sign out')
    sign_up(email: 'm@test.com')
    click_link 'KFC'
    rate_restaurant(2, 'Food was fine')
    expect(page).to have_content('Average rating: ★★★☆☆')
  end
end
