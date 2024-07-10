class ServicesController < ApplicationController

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
  end
end
