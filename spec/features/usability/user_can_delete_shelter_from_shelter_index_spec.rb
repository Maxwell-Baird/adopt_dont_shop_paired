require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  it "I can delete a shelter at '/shelters'" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    visit "/shelters"

    click_link "Delete Shelter"

    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(shelter.name)
  end
end