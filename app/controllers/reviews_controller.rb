class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)
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
