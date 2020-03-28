require 'rails_helper'

RSpec.describe Favorites, type: :model do
  describe '#total_count' do
    it 'can calculate the total number of favorite pets' do
      favorites = Favorites.new([1,2,3,4,5])

      expect(favorites.total_count).to eq(5)
    end
  end
end