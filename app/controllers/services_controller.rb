class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: %i[show edit update]

  def index
    @services = Service.all
    if params[:query].present?
      @services = @services.search_by_name_and_address(params[:query])
    end
  end

  def booking_requests
    if current_user == @service.user 
      @bookings = @service.bookings
    else
      redirect_to root_path, notice: "You are not authorized to view this page."
    end
  end

  def show
    @reviews = @service.bookings.flat_map(&:reviews)
  end

  def edit; end

  def update
    if @service.update(service_params)
      redirect_to user_services_path(@service.user_id), notice: 'Service was successfully updated.'
    else
      render :edit, alert: 'There was an error updating the service.'
    end
  end

  def new
    @service = Service.new
  end

  def create
    @service = current_user.services.build(service_params)
    if @service.save
      redirect_to @service, notion: 'New Service Created!'
    else
      render :new
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
