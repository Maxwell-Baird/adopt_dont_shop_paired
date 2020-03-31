class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find(favorites.contents)
  end

  def create
    Application.create(application_params)
    redirect_to '/shelters'
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end