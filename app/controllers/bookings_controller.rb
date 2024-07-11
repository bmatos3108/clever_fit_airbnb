class BookingsController < ApplicationController
  def past
    @bookings = Booking.where('end_date < ?', Date.today)
  end

  def new
    @service = Service.find(params[:service_id])
    @booking = Booking.new
  end

  def create
    @service = Service.find(params[:service_id])
    @booking = @service.bookings.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to user_path(@booking.user), notice: 'Booking was successfully made.'
    else
      flash[:alert] = 'There was an error submitting your booking.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    redirect_to bookings_user_path(@booking.user), status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :service_id)
  end
end
