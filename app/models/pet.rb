class Pet < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :image, :name, :description, :approx_age, :sex, :status
end