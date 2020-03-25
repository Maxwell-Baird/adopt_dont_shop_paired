require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can create a shelter review at '/shelters/:id'" do

    shelter = Shelter.create(name:    "Broomfield Pet Shelter",
                             address: "1111 fake st.",
                             city:    "Broomfield",
                             state:   "CO",
                             zip:     "80020")

    visit "/shelters/#{shelter.id}"
    click_link "New Review"

    expect(page).to have_current_path("/reviews/new")

    fill_in :title, with: "Great Place"
    fill_in :rating, with: 5
    fill_in :content, with: "Love my new fluff ball"
    fill_in :photo, with: 'http://pngimg.com/uploads/dog/dog_PNG50348.png'
    click_on "Create Review"
    expect(page).to have_current_path("/shelters/#{shelter.id}")

    within("#review-1") do
      expect(page).to have_content("Great Place")
      expect(page).to have_content(5)
      expect(page).to have_content("Love my new fluff ball")
      expect(page).to have_xpath('http://pngimg.com/uploads/dog/dog_PNG50348.png')
    end
  end
end
