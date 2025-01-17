class ReviewsController < ApplicationController
  before_action :set_booking, only: %i[new create edit destroy]
  before_action :set_review, only: %i[edit update destroy show]
  before_action :correct_user, only: %i[edit update destroy]

  def new
    @review = Review.new
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = @booking.reviews.build(review_params)
    @review.user = current_user
    # raise
    if @review.save
      redirect_to service_path(@booking.service), notice: 'Review was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to booking_path(@booking), notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to booking_path(@booking), notice: 'Review was successfully deleted.'
  end

  private

  def set_booking
    @booking = Booking.find params[:booking_id]
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
