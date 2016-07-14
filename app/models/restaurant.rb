class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_review_score
    return "N/A" if self.reviews.length == 0
    total = 0
    self.reviews.each do |review|
      total += review.rating
    end
    total / self.reviews.length
  end
end
