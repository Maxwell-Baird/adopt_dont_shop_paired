require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can see pets that have been favorited" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    pet_1 = shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                                name:         "Kona",
                                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                                approx_age:   6,
                                sex:          "male",
                                status:       "adoptable")
    pet_2 = shelter.pets.create(image:        "http://www.pngall.com/wp-content/uploads/4/Golden-Retriever-Puppy-PNG.png",
                                name:         "Max",
                                description:  "Max likes to eat all different types of food",
                                approx_age:   3,
                                sex:          "male",
                                status:       "adoptable")
    visit "/pets/#{pet_1.id}"
    click_link "Favorite Pet"

    visit "/pets/#{pet_2.id}"
    click_link "Favorite Pet"
    visit "/favorites"

    within("#pet-#{pet_1.id}") do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_css("img[src*='#{pet_1.image}']")
    end

    within("#pet-#{pet_2.id}") do
      expect(page).to have_content(pet_2.name)
      expect(page).to have_css("img[src*='#{pet_2.image}']")
    end
  end

  it "I can remove a pet that has been favorited" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    pet_1 = shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                                name:         "Kona",
                                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                                approx_age:   6,
                                sex:          "male",
                                status:       "adoptable")
    pet_2 = shelter.pets.create(image:        "http://www.pngall.com/wp-content/uploads/4/Golden-Retriever-Puppy-PNG.png",
                                name:         "Max",
                                description:  "Max likes to eat all different types of food",
                                approx_age:   3,
                                sex:          "male",
                                status:       "adoptable")
    visit "/pets/#{pet_1.id}"
    click_link "Favorite Pet"

    visit "/pets/#{pet_2.id}"
    click_link "Favorite Pet"
    visit "/favorites"

    within("#pet-#{pet_1.id}") do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_css("img[src*='#{pet_1.image}']")
      expect(page).to have_content("Remove from favorites")
    end
    within("#pet-#{pet_2.id}") do
      expect(page).to have_content(pet_2.name)
      expect(page).to have_css("img[src*='#{pet_2.image}']")
      expect(page).to have_content("Remove from favorites")
    end
    within("#pet-#{pet_1.id}") do
      click_link "Remove from favorites"
    end

    within("main") do
      expect(page).to have_no_content(pet_1.name)
      expect(page).to have_no_css("img[src*='#{pet_1.image}']")
    end

    within("#pet-#{pet_2.id}") do
      expect(page).to have_content(pet_2.name)
      expect(page).to have_css("img[src*='#{pet_2.image}']")
      expect(page).to have_content("Remove from favorites")
    end
  end

  it "will display only a statement" do

    visit "/favorites"
    expect(page).to have_content("You have no favorited pets")
  end
end
