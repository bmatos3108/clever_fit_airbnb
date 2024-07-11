class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def chef
    @user = User.find(params[:id])
    # @user.role = "chef"
  end

  def bookings
    @user = User.find(params[:id])
    @bookings = @user.bookings
  end
end
