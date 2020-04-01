require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  it "I can update a shelter at '/shelters/:id'" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    new_info = {name:     "Denver Animal Shelter",
                address:  "1241 W. Bayaud Ave.",
                city:     "Denver",
                state:    "CO",
                zip:      "80223"}

    visit "/shelters/#{shelter.id}"

    click_link "Update Shelter"

    expect(page).to have_current_path("/shelters/#{shelter.id}/edit")

    fill_in :name, with: new_info[:name]
    fill_in :address, with: new_info[:address]
    fill_in :city, with: new_info[:city]
    fill_in :state, with: new_info[:state]
    fill_in :zip, with: new_info[:zip]
    click_on "Update Shelter"

    expect(page).to have_current_path("/shelters/#{shelter.id}")
    expect(page).to have_content(new_info[:name])
    expect(page).to have_content(new_info[:address])
    expect(page).to have_content(new_info[:city])
    expect(page).to have_content(new_info[:state])
    expect(page).to have_content(new_info[:zip])
  end

  it "I can get an error for not filling out the form" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    new_info = {name:     "Denver Animal Shelter",
                address:  "1241 W. Bayaud Ave.",
                city:     "Denver",
                state:    "CO",
                zip:      "80223"}

    visit "/shelters/#{shelter.id}"

    click_link "Update Shelter"

    expect(page).to have_current_path("/shelters/#{shelter.id}/edit")

    fill_in :name, with: new_info[:name]
    fill_in :address, with: new_info[:address]
    fill_in :city, with: new_info[:city]
    fill_in :state, with: new_info[:state]
    fill_in :zip, with: ''
    click_on "Update Shelter"

    expect(page).to have_content("Shelter not updated: Required information missing")
  end
end
