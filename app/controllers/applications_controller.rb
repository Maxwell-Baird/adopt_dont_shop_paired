class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find(favorites.contents)
  end

  def create
    Application.create(application_params)
    flash[:notice] = "Your application has been submitted"
    favorites.remove_pets(params[:pets])
    redirect_to '/favorites'
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end