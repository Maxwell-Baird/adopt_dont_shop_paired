require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can update a pet at '/pets/:id'" do

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

    new_info = {image:        "https://i.imgur.com/9AyaA0q.jpg",
                name:         "Kona",
                description:  "Kona greets everyone with the biggest smile! She's always happy and is so easy to fall in love with. She seems to love everyone she meets, but can get a little overly excited some times and may knock little kids down. She is reportedly housebroken and does well when left alone in the home. She would benefit from daily walks and lots of playtime!",
                approx_age:   6,
                sex:          "female"}

    visit "/pets/#{pet.id}"
    click_link "Update Pet"

    expect(page).to have_current_path("/pets/#{pet.id}/edit")

    fill_in :image, with: new_info[:image]
    fill_in :name, with: new_info[:name]
    fill_in :description, with: new_info[:description]
    fill_in :approx_age, with: new_info[:approx_age]
    select new_info[:sex], from: :sex
    click_on "Update Pet"

    expect(page).to have_xpath("//img[contains(@src, '#{new_info[:image]}')]")
    expect(page).to have_content(new_info[:name])
    expect(page).to have_content(new_info[:description])
    expect(page).to have_content("Approximate Age: #{new_info[:approx_age]}")
    expect(page).to have_content("Sex: #{new_info[:sex]}")
    expect(page).to have_content("Status: #{pet.status}")
  end

  it "I cannot update a pet because a field is empty" do

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

    new_info = {image:        "https://i.imgur.com/9AyaA0q.jpg",
                name:         "Kona",
                description:  "Kona greets everyone with the biggest smile! She's always happy and is so easy to fall in love with. She seems to love everyone she meets, but can get a little overly excited some times and may knock little kids down. She is reportedly housebroken and does well when left alone in the home. She would benefit from daily walks and lots of playtime!",
                approx_age:   6,
                sex:          "female"}

    visit "/pets/#{pet.id}"
    click_link "Update Pet"

    expect(page).to have_current_path("/pets/#{pet.id}/edit")

    fill_in :image, with: ''
    fill_in :name, with: new_info[:name]
    fill_in :description, with: new_info[:description]
    fill_in :approx_age, with: new_info[:approx_age]
    select new_info[:sex], from: :sex
    click_on "Update Pet"

    expect(page).to have_content("Pet not updated: Required information missing")

  end
end
