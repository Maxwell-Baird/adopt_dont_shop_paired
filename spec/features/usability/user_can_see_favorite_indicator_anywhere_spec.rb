require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can see the favorite indicator from anywhere" do

    favorites = 0

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

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end

    # Shelter Index
    visit "/shelters"

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end

    # Shelter Show
    visit "/shelters/#{shelter.id}"

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end

    # Shelter New
    visit "/shelters/new"

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end

    # Shelter Edit
    visit "/shelters/#{shelter.id}/edit"

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end

    # Pet Index
    visit "/pets"

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end

    # Pet Show
    visit "/pets/#{pet.id}"

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end

    # Pet Edit
    visit "/pets/#{pet.id}/edit"

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end

    # Shelter Pet Index
    visit "/shelters/#{shelter.id}/pets"

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end

    # Shelter Pet New
    visit "/shelters/#{shelter.id}/pets/new"

    within('#favorites') do
      expect(page).to have_content("Favorites: #{favorites}")
    end
  end
end