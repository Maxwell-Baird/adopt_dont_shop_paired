require 'rails_helper'

RSpec.describe Favorites, type: :model do
  subject { Favorites.new(['1','2','3','4','5']) }
  describe '#count_of' do
    it 'calculates the total number of favorite pets' do
      expect(subject.count_of).to eq(5)
    end
  end

  describe '#add_pet' do
    it 'adds a pet to its contents' do
      subject.add_pet(10)
      subject.add_pet(42)

      expect(subject.contents).to eq(['1','2','3','4','5','10','42'])
    end
  end
end