require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can visit the Shelter Index from anywhere" do

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

    # Welcome Index
    visit "/"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")

    # Shelter Index
    visit "/shelters"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")

    # Shelter Show
    visit "/shelters/#{shelter.id}"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")

    # Shelter New
    visit "/shelters/new"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")

    # Shelter Edit
    visit "/shelters/#{shelter.id}/edit"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")

    # Pet Index
    visit "/pets"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")

    # Pet Show
    visit "/pets/#{pet.id}"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")

    # Pet Edit
    visit "/pets/#{pet.id}/edit"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")

    # Shelter Pet Index
    visit "/shelters/#{shelter.id}/pets"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")

    # Shelter Pet New
    visit "/shelters/#{shelter.id}/pets/new"
    click_link("Shelter Index")

    expect(page).to have_current_path("/shelters")
  end
end