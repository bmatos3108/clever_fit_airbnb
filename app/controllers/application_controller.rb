class ApplicationController < ActionController::Base
  def show
    @service = Service.find(params[:id])
    @reviews = @service.reviews
  end

  def toggle_chef_mode
    if session[:chef_mode]
      session[:chef_mode] = false
    else
      session[:chef_mode] = true
    end
  end
end
