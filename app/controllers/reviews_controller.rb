class ReviewsController < ApplicationController
  before_action :set_booking, only: %i[new edit destroy]

  def new
    @service = Service.find(params[:service_id])
    @review = @booking.reviews.build
    @review.booking.user_id = current_user.id
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = @booking.reviews.build(review_params)
    @review.booking.user = current_user
    if @review.save
      redirect_to service_path(@booking.service), notice: 'Review was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
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
    @booking = Booking.find_by(service: params[:service_id], user: current_user)
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
