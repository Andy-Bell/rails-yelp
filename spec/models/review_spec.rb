require 'rails_helper'

describe 'Review' do
  it 'is invalid if rating is higher than 5' do
    review = Review.new(rating: 6)
    expect(review).to have(1).error_on(:rating)
    expect(review).not_to be_valid
  end
end
