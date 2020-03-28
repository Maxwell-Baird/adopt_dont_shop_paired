class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    @favorites = Favorites.new(session[:favorites])
    @favorites.add_pet(pet.id)
    session[:favorites] = @favorites.contents
    flash[:notice] = "#{pet.name} at #{pet.shelter.name} has been added to favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def index
  end
end