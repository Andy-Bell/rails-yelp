class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @average = @restaurant.average_review_score
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to '/restaurants'
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    Restaurant.update(restaurant_params)
    @restaurant = Restaurant.find(params[:id])
    redirect_to restaurant_path(@restaurant)
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end


end
