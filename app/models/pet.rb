class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def remove_from_applications(pet_id)
    applications.each do |application|
      application.pets.destroy(pet_id)
    end
  end

  validates_presence_of :image, :name, :description, :approx_age, :sex, :status
end
