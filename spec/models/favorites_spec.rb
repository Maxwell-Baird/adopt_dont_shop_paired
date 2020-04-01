require 'rails_helper'

RSpec.describe Favorites, type: :model do
  subject { Favorites.new([]) }
  before(:each) do
    shelter = Shelter.create(name:     "Dumb Friends League",
                             address:  "2080 S. Quebec St.",
                             city:     "Denver",
                             state:    "CO",
                             zip:      "80231")

    @pet1 = Pet.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                       name:         "Kona",
                       description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                       approx_age:   6,
                       sex:          "male",
                       status:       "adoptable",
                       shelter_id:   shelter.id)
    @pet2 = Pet.create(image:        "https://i.imgur.com/sS9UGFN.jpg",
                       name:         "Benji",
                       description:  "Benji is a wonderful boy with a great smile! He loves his people and is happiest by their side. In the past, he spent most of his time in the yard and was crated at night indoors. This has given him little chance of socialization outside of his home and family. Like many dogs, being in a shelter can be scary. This is especially true for dogs like Benji, who have never left their property.",
                       approx_age:   2,
                       sex:          "male",
                       status:       "pending adoption",
                       shelter_id:   shelter.id)
  end

  describe '#add_pet' do
    it 'adds a pet to its contents' do
      subject.add_pet(@pet1.id)
      subject.add_pet(@pet2.id)

      expect(subject.contents).to eq([@pet1.id.to_s, @pet2.id.to_s])
    end
  end

  describe '#count_of' do
    it 'calculates the total number of favorite pets' do
      subject.add_pet(@pet1.id)
      subject.add_pet(@pet2.id)

      expect(subject.count_of).to eq(2)
    end
  end

  describe '#find_pet' do
    it 'finds the pet object' do
      expect(subject.find_pet(@pet1.id)).to eq(@pet1)
    end
  end

  describe '#been_favorited' do
    it 'checks if the pet has been favorited' do
      expect(subject.been_favorited(@pet1.id)).to eq(false)

      subject.add_pet(@pet1.id)

      expect(subject.been_favorited(@pet1.id.to_s)).to eq(true)
    end
  end

  describe '#remove_pet' do
    it 'removes a given pet id' do
      subject.add_pet(@pet1.id)
      subject.add_pet(@pet2.id)
      subject.remove_pet(@pet1.id)

      expect(subject.contents).to eq([@pet2.id.to_s])
    end
  end

  describe '#remove_pets' do
    it 'removes all given pet ids' do
      subject.add_pet(@pet1.id)
      subject.add_pet(@pet2.id)
      subject.remove_pets([@pet1.id, @pet2.id])

      expect(subject.contents).to eq([])
    end
  end

  describe '#remove_all_pets' do
    it 'removes all pet ids' do
      subject.add_pet(@pet1.id)
      subject.add_pet(@pet2.id)
      subject.remove_all_pets

      expect(subject.contents).to eq([])
    end
  end
end
