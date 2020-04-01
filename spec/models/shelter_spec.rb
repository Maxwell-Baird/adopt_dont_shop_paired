require 'rails_helper'

describe Shelter, type: :model do

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  describe '#average_rating' do
    it 'averages review ratings for the shelter' do
      shelter = Shelter.create(name:     "Dumb Friends League",
                               address:  "2080 S. Quebec St.",
                               city:     "Denver",
                               state:    "CO",
                               zip:      "80231")
      shelter.reviews.create(title:    "Awesome place!",
                             rating:   5,
                             content:  "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                             photo:    "https://i.imgur.com/c6SIBcM.jpg")
      shelter.reviews.create(title:    "ok place!",
                             rating:   3,
                             content:  "Cute animals!")
      pet = shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                                name:         "Kona",
                                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                                approx_age:   6,
                                sex:          "male",
                                status:       "adoptable")
      pet.applications.create(name:         "Rick Astley",
                              address:      "123 Wisteria Ln",
                              city:         "Denver",
                              state:        "CO",
                              zip:          "80202",
                              phone:        "123-4567",
                              description:  "I would make a great dog dad!")

      expect(shelter.average_rating).to eq(4.0)
    end
  end

  describe '#application_count' do
    it 'counts how many applications are on file for the shelter' do
      shelter = Shelter.create(name:     "Dumb Friends League",
                               address:  "2080 S. Quebec St.",
                               city:     "Denver",
                               state:    "CO",
                               zip:      "80231")
      shelter.reviews.create(title:    "Awesome place!",
                             rating:   5,
                             content:  "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                             photo:    "https://i.imgur.com/c6SIBcM.jpg")
      shelter.reviews.create(title:    "ok place!",
                             rating:   3,
                             content:  "Cute animals!")
      pet = shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                                name:         "Kona",
                                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                                approx_age:   6,
                                sex:          "male",
                                status:       "adoptable")
      pet.applications.create(name:         "Rick Astley",
                              address:      "123 Wisteria Ln",
                              city:         "Denver",
                              state:        "CO",
                              zip:          "80202",
                              phone:        "123-4567",
                              description:  "I would make a great dog dad!")

      expect(shelter.application_count).to eq(1)
    end
  end

end