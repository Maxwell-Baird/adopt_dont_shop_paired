class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find(favorites.contents)
  end

  def create
    if valid_params?
      application = Application.create(application_params)
      application.pets << params[:pets].map { |pet_id_str| Pet.find(pet_id_str.to_i) }
      flash[:notice] = "Your application has been submitted."
      favorites.remove_pets(params[:pets])
      redirect_to '/favorites'
    else
      flash[:notice] = "Application not submitted. Please complete all fields."
      redirect_to "/applications/new"
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end

  def valid_params?
    required_params = application_params.values_at(:name, :address, :city, :state, :zip, :phone, :description)
    required_params.none?(&:empty?)
  end
end