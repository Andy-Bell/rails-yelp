require 'rails_helper'

describe 'Restaurant' do
  describe 'validation' do
    it 'is not valid with a name of less than three letters' do
      restaurant = Restaurant.new(name: 'KF')
      expect(restaurant).to have(1).error_on(:name)
      expect(restaurant).not_to be_valid
    end
  end
end
