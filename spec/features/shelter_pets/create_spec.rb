require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can create a shelter pet at '/shelters/:id/pets'" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    new_info = {image:        "https://i.imgur.com/9AyaA0q.jpg",
                name:         "Kona",
                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                approx_age:   6,
                sex:          "male"}

    visit "/shelters/#{shelter.id}/pets/"

    click_link "Create Pet"

    expect(page).to have_current_path("/shelters/#{shelter.id}/pets/new")

    fill_in :image, with: new_info[:image]
    fill_in :name, with: new_info[:name]
    fill_in :description, with: new_info[:description]
    fill_in :approx_age, with: new_info[:approx_age]
    select new_info[:sex], from: :sex
    click_on "Create Pet"

    expect(page).to have_current_path("/shelters/#{shelter.id}/pets")
    expect(page).to have_xpath("//img[contains(@src, '#{new_info[:image]}')]")
    expect(page).to have_content(new_info[:name])
    expect(page).to have_content(new_info[:approx_age])
    expect(page).to have_content(new_info[:sex])
    expect(page).to have_content("Status: adoptable")
  end

  it "I cannot create a shelter pet if fields are not filled out" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    new_info = {image:        "https://i.imgur.com/9AyaA0q.jpg",
                name:         "Kona",
                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                approx_age:   6,
                sex:          "male"}

    visit "/shelters/#{shelter.id}/pets/"

    click_link "Create Pet"

    expect(page).to have_current_path("/shelters/#{shelter.id}/pets/new")

    fill_in :image, with: new_info[:image]
    fill_in :name, with: new_info[:name]
    fill_in :description, with: new_info[:description]
    fill_in :approx_age, with: ''
    select new_info[:sex], from: :sex
    click_on "Create Pet"

    expect(page).to have_content("Pet not created: Required information missing.")
  end
end
