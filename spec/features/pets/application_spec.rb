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

    application_info_1 = {name: "Rick Astley",
                        address:      "123 Wisteria Ln",
                        city:         "Denver",
                        state:        "CO",
                        zip:          "80202",
                        phone:        "123-4567",
                        description:  "I would make a great dog dad!"}


    visit "/pets/#{pet.id}"
    click_link "Favorite Pet"

    visit "/favorites"
    click_link "Adopt Pets"
    select pet.name, from: :pets
    fill_in :name, with: application_info_1[:name]
    fill_in :address, with: application_info_1[:address]
    fill_in :city, with: application_info_1[:city]
    fill_in :state, with: application_info_1[:state]
    fill_in :zip, with: application_info_1[:zip]
    fill_in :phone, with: application_info_1[:phone]
    fill_in :description, with: application_info_1[:description]
    click_button "Submit Application"
    application = Application.first
    visit "/favorites"

    visit "/pets/#{pet.id}"

    expect(page).to have_content("Applications")
    click_link "Applications"
    expect(page).to have_current_path("/pets/#{pet.id}/applications")
    expect(page).to have_content(application_info_1[:name])
    click_link "#{application_info_1[:name]}"
    expect(page).to have_current_path("/applications/#{application.id}")
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
