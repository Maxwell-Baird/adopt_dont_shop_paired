require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  it "I can delete a pet at '/pets/:id'" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    pet = shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                              name:         "Kona",
                              description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                              approx_age:   6,
                              sex:          "male",
                              status:       "adoptable")


    visit "/pets/#{pet.id}"

    click_link "Delete Pet"

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(pet.name)
  end

  it "I cannot delete a pet that is pending" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    pet = shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                              name:         "Kona",
                              description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                              approx_age:   6,
                              sex:          "male",
                              status:       "Pending")


    visit "/pets/#{pet.id}"

    click_link "Delete Pet"

    expect(page).to have_content("Sorry this pet is currently in pending")
  end

  it "Deleting a pet removes it from favorites'" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    pet = shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                              name:         "Kona",
                              description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                              approx_age:   6,
                              sex:          "male",
                              status:       "adoptable")


    visit "/pets/#{pet.id}"
    click_link "Favorite Pet"

    within('#favorites') do
      expect(page).to have_content("Favorites: 1")
    end

    click_link "Delete Pet"

    within('#favorites') do
      expect(page).to have_content("Favorites: 0")
    end
  end

  it "Deleting a pet removes it from applications'" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    pet1 = shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                              name:         "Kona",
                              description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                              approx_age:   6,
                              sex:          "male",
                              status:       "adoptable")



    applicant_1 = pet1.applications.create(name: "Rick Astley",
                        address:      "123 Wisteria Ln",
                        city:         "Denver",
                        state:        "CO",
                        zip:          "80202",
                        phone:        "123-4567",
                        description:  "I would make a great dog dad!")

    applicant_1.pets.create(image:        "https://i.imgur.com/sS9UGFN.jpg",
                      name:         "Benji",
                      description:  "Benji is a wonderful boy with a great smile! He loves his people and is happiest by their side. In the past, he spent most of his time in the yard and was crated at night indoors. This has given him little chance of socialization outside of his home and family. Like many dogs, being in a shelter can be scary. This is especially true for dogs like Benji, who have never left their property.",
                      approx_age:   2,
                      sex:          "male",
                      status:       "pending adoption",
                      shelter_id:   shelter.id)
    visit "/applications/#{applicant_1.id}"
    expect(page).to have_content("Benji")
    expect(page).to have_content("Kona")

    visit "/pets/#{pet1.id}"


    click_link "Delete Pet"
    visit "/applications/#{applicant_1.id}"
    expect(page).to have_content("Benji")
    expect(page).to have_no_content("Kona")

  end

end
