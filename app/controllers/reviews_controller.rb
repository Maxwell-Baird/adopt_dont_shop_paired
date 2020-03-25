class ReviewsController < ApplicationController
  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.update(params[:id], review_params)
    redirect_to "/shelters/#{review.shelter.id}"
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.reviews.create(review_params)
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :photo)
  end
end
