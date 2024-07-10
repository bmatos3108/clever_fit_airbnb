class ReviewsController < ApplicationController
  before_action :set_reviews, only: %i[new create]
  before_action :set_services, only: %i[show edit update destroy]

  def index
    @reviews = @user.reviews
  end
  def edit
    @reviews = Review.find(params[:id])
  end
  def show
    @reviews = @service.reviews.find(params[:id])
  end

  def new
    @reviews = @service.reviews.new
  end

  def create
    @reviews = @service.reviews.new(review_params)
    @reviews.user = current_user
    if @reviews.save
      redirect_to @service, notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  # Remove the duplicate method definition

  def update
    if @reviews.update(review_params)
      redirect_to @reviews.service, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @service = @reviews.service
    @reviews.destroy
    redirect_to @service, notice: 'Review was successfully deleted.'
  end

  private

  def set_reviews
    @reviews = Review.find(params[:id])
  end

  def set_service
    @service = Service.find(params[:service_id])
  end

  def review_params
    params.require(:reviews).permit(:rating, :comment)
  end
end
