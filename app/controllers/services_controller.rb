class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update]

  def show; end

  def edit; end

  def update; end

  private

  def set_service
    @service = Service.find(params[:id])
  end
end
