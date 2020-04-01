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
    @pet = Pet.update(params[:id], pet_params)
    if @pet.update_attributes(pet_params)
      redirect_to "/pets/#{@pet.id}"
    else
      flash.now[:notice] = "Pet not updated: Required information missing."
      render :edit
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    if @pet.status == 'adoptable'
      Pet.destroy(params[:id])
      redirect_to "/pets"
    else
      flash[:notice] = "Sorry this pet is currently in pending"
      render :show
    end
  end

  def applications
    @pet = Pet.find(params[:id])
  end



  private

  def pet_params
    params.permit(:image, :name, :description, :approx_age, :sex, :status)
  end
end
