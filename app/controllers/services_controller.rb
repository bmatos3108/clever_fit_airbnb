class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: %i[show edit update]

  def index
    @services = params[:query].present? ? Service.search_by_name_and_address(params[:query]) : Service.all
  end

  def show
    @bookings = @service.bookings
  end

  def edit; end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: 'Service was successfully updated.'
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
      redirect_to @service, notice: 'New Service Created!'
    else
      render :new, status: :unprocessable_entity
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
