require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can see a shelter by clicking its name anywhere" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                        name:         "Kona",
                        description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                        approx_age:   6,
                        sex:          "male",
                        status:       "adoptable")

    visit "/shelters"
    click_link "#{shelter.name}"

    expect(page).to have_current_path("/shelters/#{shelter.id}")

    visit "/pets"
    click_link "#{shelter.name}"

    expect(page).to have_current_path("/shelters/#{shelter.id}")

    visit "/shelters/#{shelter.id}/pets"
    click_link "#{shelter.name}"

    expect(page).to have_current_path("/shelters/#{shelter.id}")
  end
end