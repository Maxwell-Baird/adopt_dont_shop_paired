require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can see a shelter at '/shelters/:id'" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")
    review = shelter.reviews.create(title:    "Awesome place!",
                                    rating:   5,
                                    content:  "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                                    photo:    "https://i.imgur.com/c6SIBcM.jpg")

    visit "/shelters/#{shelter.id}"
    within("#information") do
      expect(page).to have_content(shelter.name)
      expect(page).to have_content(shelter.address)
      expect(page).to have_content(shelter.city)
      expect(page).to have_content(shelter.state)
      expect(page).to have_content(shelter.zip)
    end
    within("#review-#{review.id}") do
      expect(page).to have_content(review.title)
      expect(page).to have_content(review.rating)
      expect(page).to have_content(review.content)
      expect(page).to have_xpath("//img[contains(@src, '#{review.photo}')]")
    end
  end
end