require_relative 'restaurant'

class Review < ApplicationRecord
  include ActiveModel::Validations
  validates :rating, inclusion: (1..5)
  validate :user_different_to_reviewer?

  def user_different_to_reviewer?
    # p self
    restaurant = Restaurant.find(self.restaurant_id)
    # p restaurant
    # # restaurant.user_id != self.user_id
    errors.add(:user_id, 'You cannot review a restaurant on your account.') unless restaurant.user_id != self.user_id
  end
end
