class ApplicationController < ActionController::Base
  def show
    @service = Service.find(params[:id])
    @reviews = @service.reviews
  end
end
