class ReviewsController < ApplicationController
  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if valid_params?
      Review.update(params[:id], review_params)
      redirect_to "/shelters/#{@review.shelter.id}"
    else
      flash.now[:notice] = "Review not updated: Required information missing."
      render :edit
    end
  end

  private

  def valid_params?
    required_params = review_params.values_at(:title, :rating, :content)
    required_params.none?(&:empty?)
  end

  def review_params
    params.permit(:title, :rating, :content, :photo)
  end
end