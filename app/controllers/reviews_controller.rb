class ReviewsController < ApplicationController
  before_action :set_review, only: %i[new create]
  before_action :set_service, only: %i[show edit update destroy]

  def index
    @user = User.find(params[:user_id])
    @reviews = @user.reviews
  end

  def show
  end

  def new
    @review = @service.reviews.new
  end

  def create
    @review = @service.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @service, notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review.service, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @service = @review.service
    @review.destroy
    redirect_to @service, notice: 'Review was successfully deleted.'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_service
    @service = Service.find(params[:service_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
