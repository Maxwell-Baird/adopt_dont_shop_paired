class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.update(params[:id], pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  def applications
    @pet = Pet.find(params[:id])
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :approx_age, :sex, :status)
  end
end
