class ServicesController < ApplicationController

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      @user_id = @service.user_id
      redirect_to user_services_path(@user_id), notice: 'Service was successfully updated.'
    else
      render :edit, alert: 'There was an error updating the service.'
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :address, :description_menu, :price)
  end
end
