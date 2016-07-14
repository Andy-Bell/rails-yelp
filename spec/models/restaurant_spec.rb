require 'rails_helper'

describe 'Restaurant' do
  describe 'validation' do
    it 'is not valid with a name of less than three letters' do
      restaurant = Restaurant.new(name: 'KF')
      expect(restaurant).to have(1).error_on(:name)
      expect(restaurant).not_to be_valid
    end

    it 'is not valid unless it has a unique name' do
      Restaurant.create(name: 'Torinos')
      restaurant = Restaurant.new(name: 'Torinos')
      expect(restaurant).to have(1).error_on(:name)
      expect(restaurant).not_to be_valid
    end
  end

  describe '#average_rating' do

    context 'there are no reviews' do
      it 'returns N/A when there are no reviews' do
        restaurant = Restaurant.create(name: 'Andys Place')
        expect(restaurant.average_review_score).to eq 'N/A'
      end
    end

    context 'two reviews' do
      it 'accurately calculates the average rating' do
        restaurant = Restaurant.create(name: 'Andys Place')
        restaurant.reviews.create(rating: 4, comments: 'Nice')
        restaurant.reviews.create(rating: 2, comments: 'A hell hole')
        expect(restaurant.average_review_score).to eq 3
      end
    end
  end
end
