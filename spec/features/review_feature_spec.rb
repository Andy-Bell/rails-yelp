feature 'restaurants review' do

	let!(:restaurant) do
		Restaurant.create(name: 'KFC', description: 'Delicious')
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
end
