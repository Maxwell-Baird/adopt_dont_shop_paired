class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    @pet = @shelter.pets.new(pet_params)
    if @pet.save
      redirect_to "/shelters/#{params[:shelter_id]}/pets"
    else
      flash[:notice] = "Pet not created: Required information missing."
      render :new
    end
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :approx_age, :sex, :status)
  end
end
