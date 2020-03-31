class FavoritesController < ApplicationController
  def index
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    flash[:notice] = "#{pet.name} at #{pet.shelter.name} has been added to favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    if params[:pet_id] == nil
      session[:favorites] = []
    else
      pet = Pet.find(params[:pet_id])
      favorites.remove_pet(pet.id)
      session[:favorites] = favorites.contents
      flash[:notice] = "#{pet.name} at #{pet.shelter.name} has been removed from favorites"
    end
    redirect_back fallback_location: @post
  end
end
