require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :image }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description}
    it { should validate_presence_of :approx_age }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :application_pets }
    it { should have_many(:applications).through(:application_pets) }
  end

  describe '#remove_from_applications' do
    it 'removes all mentions of the pet from applications' do
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

    applicant_1 = pet1.applications.create(name: "Rick Astley",
                        address:      "123 Wisteria Ln",
                        city:         "Denver",
                        state:        "CO",
                        zip:          "80202",
                        phone:        "123-4567",
                        description:  "I would make a great dog dad!")

      expect(pet1.applications).to eq([applicant_1])
      expect(applicant_1.pets).to eq([pet1])
      pet1.remove_from_applications(pet1.id)
      expect(applicant_1.pets).to eq([])
    end
  end
  describe '#applicant' do
    it 'returns the name of the applicant' do
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

    applicant_1 = pet1.applications.create(name: "Rick Astley",
                        address:      "123 Wisteria Ln",
                        city:         "Denver",
                        state:        "CO",
                        zip:          "80202",
                        phone:        "123-4567",
                        description:  "I would make a great dog dad!")
      pet1.application_approved = applicant_1.id
      expect(pet1.applicant).to eq("Rick Astley")
    end
  end
end
