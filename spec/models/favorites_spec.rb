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

  describe '#find_pet' do
    it 'finds the pet object' do
      shelter1 = Shelter.create(name:     "Dumb Friends League",
                                address:  "2080 S. Quebec St.",
                                city:     "Denver",
                                state:    "CO",
                                zip:      "80231")
      pet1 = Pet.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                        name:         "Kona",
                        description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                        approx_age:   6,
                        sex:          "male",
                        status:       "adoptable",
                        shelter_id:   shelter1.id)
      subject.add_pet(pet1.id)

      expect(subject.find_pet(pet1.id)).to eq(pet1)
    end
  end

    describe '#been_favorited' do
      it 'checks if the pet has been favorited' do
        shelter1 = Shelter.create(name:     "Dumb Friends League",
                                  address:  "2080 S. Quebec St.",
                                  city:     "Denver",
                                  state:    "CO",
                                  zip:      "80231")
        pet1 = Pet.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                          name:         "Kona",
                          description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                          approx_age:   6,
                          sex:          "male",
                          status:       "adoptable",
                          shelter_id:   shelter1.id)
        expect(subject.been_favorited(pet1.id)).to eq(false)
        subject.add_pet(pet1.id)

        expect(subject.been_favorited(pet1.id.to_s)).to eq(true)
      end
    end

    describe '#remove_pet' do
      it 'removes the pet id' do
        shelter1 = Shelter.create(name:     "Dumb Friends League",
                                  address:  "2080 S. Quebec St.",
                                  city:     "Denver",
                                  state:    "CO",
                                  zip:      "80231")
        pet1 = Pet.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                          name:         "Kona",
                          description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                          approx_age:   6,
                          sex:          "male",
                          status:       "adoptable",
                          shelter_id:   shelter1.id)
        subject.add_pet(pet1.id)
        subject.remove_pet(pet1.id)
        expect(subject.contents).to eq(['1','2','3','4','5'])
      end
    end
end
