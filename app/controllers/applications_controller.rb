class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find(favorites.contents)
  end

  def create
    application = Application.create(application_params)
    application.pets << params[:pets].map { |pet_id_str| Pet.find(pet_id_str.to_i) }
    flash[:notice] = "Your application has been submitted"
    favorites.remove_pets(params[:pets])
    redirect_to '/favorites'
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end