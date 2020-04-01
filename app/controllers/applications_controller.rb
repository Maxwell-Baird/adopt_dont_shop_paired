class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find(favorites.contents)
  end

  def show
    @application = Application.find(params[:id])
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      @application.pets << params[:pets].map { |pet_id_str| Pet.find(pet_id_str.to_i) }
      flash[:notice] = "Your application has been submitted."
      favorites.remove_pets(params[:pets])
      redirect_to '/favorites'
    else
      flash[:notice] = "Application not submitted. Please complete all fields."
      redirect_to "/applications/new"
    end
  end

  def update
    @application = Application.find(params[:application_id])
    if params[:pet_id].nil?
      params[:pets].each do |pet_id_str|
        Pet.update(pet_id_str, status: "pending", approved_for: @application.name)
      end
    else
      Pet.update(params[:pet_id], status: "pending", approved_for: @application.name)
      redirect_to "/pets/#{params[:pet_id]}"
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end