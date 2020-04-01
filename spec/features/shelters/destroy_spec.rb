require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  it "I can delete a shelter at '/shelters/:id'" do
    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    visit "/shelters/#{shelter.id}"

    click_link "Delete Shelter"

    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(shelter.name)
  end

  it "I cannot delete a shelter with pets pending adoption" do
    shelter = Shelter.create(name:    "Dumb Friends League",
                              address: "2080 S. Quebec St.",
                              city:    "Denver",
                              state:   "CO",
                              zip:     "80231")
    shelter.pets.create(image:       "https://i.imgur.com/9AyaA0q.jpg",
                        name:         "Kona",
                        description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                        approx_age:   6,
                        sex:          "male",
                        status:       "pending")

    visit "/shelters/#{shelter.id}"
    click_link "Delete Shelter"
    expect(page).to have_current_path("/shelters/#{shelter.id}")
    expect(page).to have_content("Cannot delete a shelter with pets pending adoption")
  end
end