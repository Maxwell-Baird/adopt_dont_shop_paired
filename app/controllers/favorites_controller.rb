class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])

    pet_id_str = pet.id.to_s
    session[:favorites] ||= Array.new
    session[:favorites] << pet_id_str
    require 'pry'; binding.pry

    flash[:notice] = "#{pet.name} at #{pet.shelter.name} has been added to favorites"
    redirect_to "/pets/#{pet.id}"
  end
end