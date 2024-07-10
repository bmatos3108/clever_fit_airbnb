class ReviewsController < ApplicationController


  def show
    @review = @service.reviews.find(params[:id])
  end

end
