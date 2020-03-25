class ReviewsController < ApplicationController
  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.update(params[:id], review_params)
    redirect_to "/shelters/#{review.shelter.id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :photo)
  end
end