require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do

  it "I can see a pet's applications at '/pets/:id/applications'" do


    shelter1 = Shelter.create(name:    "Dumb Friends League",
                              address: "2080 S. Quebec St.",
                              city:    "Denver",
                              state:   "CO",
                              zip:     "80231")
    pet = shelter1.pets.create(image:       "https://i.imgur.com/9AyaA0q.jpg",
                                name:         "Kona",
                                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                                approx_age:   6,
                                sex:          "male",
                                status:       "adoptable")

    applicant_1 = pet.applications.create(name: "Rick Astley",
                        address:      "123 Wisteria Ln",
                        city:         "Denver",
                        state:        "CO",
                        zip:          "80202",
                        phone:        "123-4567",
                        description:  "I would make a great dog dad!")

  applicant_2 = pet.applications.create(name: "Maxwell Baird",
                      address:      "123 Wisteria Ln",
                      city:         "Denver",
                      state:        "CO",
                      zip:          "80202",
                      phone:        "123-4567",
                      description:  "I would make a great dog dad!")


    visit "/pets/#{pet.id}"

    expect(page).to have_content("Applications")
    click_link "Applications"
    expect(page).to have_current_path("/pets/#{pet.id}/applications")
    expect(page).to have_content(applicant_1.name)
    expect(page).to have_content(applicant_2.name)
    click_link "#{applicant_1.name}"
    expect(page).to have_current_path("/applications/#{applicant_1.id}")
  end

  it "I can see a no applications at '/pets/:id/applications'" do


    shelter1 = Shelter.create(name:    "Dumb Friends League",
                              address: "2080 S. Quebec St.",
                              city:    "Denver",
                              state:   "CO",
                              zip:     "80231")
    pet = shelter1.pets.create(image:       "https://i.imgur.com/9AyaA0q.jpg",
                                name:         "Kona",
                                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                                approx_age:   6,
                                sex:          "male",
                                status:       "adoptable")


    visit "/pets/#{pet.id}"

    click_link "Applications"
    expect(page).to have_current_path("/pets/#{pet.id}/applications")
    expect(page).to have_content("Sorry, there are no applications filled out for #{ pet.name}")

  end

end
