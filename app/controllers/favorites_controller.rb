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
    @favorites = Favorites.new(session[:favorites])
  end

  def destroy
    if params[:pet_id] == nil
      session[:favorites] = []
    else
      pet = Pet.find(params[:pet_id])
      @favorites = Favorites.new(session[:favorites])
      @favorites.remove_pet(pet.id)
      session[:favorites] = @favorites.contents
      flash[:notice] = "#{pet.name} at #{pet.shelter.name} has been removed from favorites"
      
    end
    redirect_back fallback_location: @post
  end

  def destroy_all


    redirect_to "/favorites"
  end
end
