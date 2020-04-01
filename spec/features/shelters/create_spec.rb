require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
    it "I can create a shelter at '/shelters'" do

      new_info = {name:     "Dumb Friends League",
                  address:  "2080 S. Quebec St.",
                  city:     "Denver",
                  state:    "CO",
                  zip:      "80231"}

      visit "/shelters"

      click_link "New Shelter"

      expect(page).to have_current_path("/shelters/new")

      fill_in :name, with: new_info[:name]
      fill_in :address, with: new_info[:address]
      fill_in :city, with: new_info[:city]
      fill_in :state, with: new_info[:state]
      fill_in :zip, with: new_info[:zip]
      click_on "Create Shelter"

      expect(page).to have_current_path("/shelters")
      expect(page).to have_content(new_info[:name])
  end

  it "I can get an error for not filling out the form" do

    new_info = {name:     "Dumb Friends League",
                address:  "2080 S. Quebec St.",
                city:     "Denver",
                state:    "CO",
                zip:      "80231"}

    visit "/shelters"

    click_link "New Shelter"

    expect(page).to have_current_path("/shelters/new")

    fill_in :name, with: new_info[:name]
    fill_in :address, with: new_info[:address]
    fill_in :city, with: new_info[:city]
    fill_in :state, with: new_info[:state]
    click_on "Create Shelter"

    expect(page).to have_content("Shelter not created: Required information missing.")
end
end
