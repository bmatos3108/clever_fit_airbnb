class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update]

  def index
    @user = User.find(params[:user_id])
    @services = @user.services
  end

  def show
  @service = Service.find(params[:id])
  @reviews = @service.bookings.map(&:reviews).flatten
  end

  def edit; end

  def update
    if @service.update(service_params)
      redirect_to user_services_path(@service.user_id), notice: 'Service was successfully updated.'
    else
      render :edit, alert: 'There was an error updating the service.'
    end
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :address, :description_menu, :price)
  end
end
