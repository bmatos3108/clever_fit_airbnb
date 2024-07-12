class UsersController < ApplicationController

  def show
    toggle_chef_mode
    @user = User.find(params[:id])
    # raise
  end

  def chef
    toggle_chef_mode
    @user = User.find(params[:id])
    # @user.role = "chef"
  end

  def bookings
    # toggle_chef_mode
    @user = current_user
    @bookings = @user.reload.bookings
    @services = Service.where(user: current_user)
    @requests = Booking.where(service: @services)
    # raise
  end

  def myservices
    @user = current_user
    @services = @user.services
  end

  private

  # def toggle_chef_mode
  #   if session[:chef_mode]
  #     session[:chef_mode] = false
  #   else
  #     session[:chef_mode] = true
  #   end
  # end
end
