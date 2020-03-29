require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can see all shelters at '/shelters'" do

    shelter1 = Shelter.create(name:     "Dumb Friends League",
                              address:  "2080 S. Quebec St.",
                              city:     "Denver",
                              state:    "CO",
                              zip:      "80231")
    shelter2 = Shelter.create(name:     "Denver Animal Shelter",
                              address:  "1241 W. Bayaud Ave.",
                              city:     "Denver",
                              state:    "CO",
                              zip:      "80223")

    visit "/shelters"

    expect(page).to have_content(shelter1.name)
    expect(page).to have_content(shelter2.name)
  end
end