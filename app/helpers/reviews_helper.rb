module ReviewsHelper
  def star_rating(rating)
    return rating if rating == 'N/A'
    remainder = 5 - rating.round
    '★' * rating.round + '☆' * remainder
  end

end
