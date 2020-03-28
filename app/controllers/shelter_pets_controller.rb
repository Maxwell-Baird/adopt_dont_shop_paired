class ShelterPetsController < ApplicationController
  def index
    @favorites = Favorites.new(session[:favorites])
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @favorites = Favorites.new(session[:favorites])
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.pets.create(pet_params)
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :approx_age, :sex, :status)
  end
end
