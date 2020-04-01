class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews, dependent: :destroy

  validates_presence_of :name, :address, :city, :state, :zip

  def average_rating
    reviews.empty? ? 0 : reviews.sum { |review| review.rating }.fdiv(reviews.length)
  end

  def application_count
    pets.empty? ? 0 : pets.joins(:applications).length
  end
end