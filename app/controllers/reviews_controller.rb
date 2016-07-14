class ReviewsController < ApplicationController

  load_and_authorize_resource :restaurant
  load_and_authorize_resource :review, :through => :restaurant


  def new
    # p @review
    # @review = Review.new
  end

  def create
    # @review = @restaurant.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      flash.now[:notice] = 'You cannot review a restaurant on your account.'
      render 'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:comments, :rating)
  end
end
