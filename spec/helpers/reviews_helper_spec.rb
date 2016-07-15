require 'rails_helper'

RSpec.describe ReviewsHelper, type: :helper do
  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'should return five stars for five' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'should return three stars for three' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'should return four stars for three and a half average' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end
end
