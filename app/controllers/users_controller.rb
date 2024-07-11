class UsersController < ApplicationController

  def show
    toggle_chef_mode
    @user = User.find(params[:id])
  end

  def chef
    toggle_chef_mode
    @user = User.find(params[:id])
    # @user.role = "chef"
  end

  def bookings
    @user = User.find(params[:id])
    @bookings = @user.bookings
  end

  def myservices
    @user = current_user
    @services = @user.services
  end
end
