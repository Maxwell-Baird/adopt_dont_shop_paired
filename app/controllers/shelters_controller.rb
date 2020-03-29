class SheltersController < ApplicationController
  def index
    @favorites = Favorites.new(session[:favorites])
    @shelters = Shelter.all
  end

  def show
    @favorites = Favorites.new(session[:favorites])
    @shelter = Shelter.find(params[:id])
  end

  def new
    @favorites = Favorites.new(session[:favorites])
  end

  def create
    Shelter.create(shelter_params)
    redirect_to '/shelters'
  end

  def edit
    @favorites = Favorites.new(session[:favorites])
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.update(params[:id], shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to "/shelters"
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
