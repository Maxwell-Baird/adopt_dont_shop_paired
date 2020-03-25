require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can delete a shelter review at '/shelters/:id'" do

    shelter = Shelter.create(name:    "Broomfield Pet Shelter",
                             address: "1111 fake st.",
                             city:    "Broomfield",
                             state:   "CO",
                             zip:     "80020")

   review_1 = shelter.reviews.create(title:    "Awesome place!",
                                   rating:   5,
                                   content:  "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                                   photo:    "https://i.imgur.com/c6SIBcM.jpg")

   review_2 = shelter.reviews.create(title:    "Great Place",
                                   rating:   5,
                                   content:  "Love my new fluff ball",
                                   photo:    "http://www.pngall.com/wp-content/uploads/4/Golden-Retriever-Puppy-PNG.png")

    visit "/shelters/#{shelter.id}"
    click_link( "Delete Review #{review_1.id}")

    within("#review-#{review_1.id}") do
      expect(page).to_not have_content(review_1.title)
      expect(page).to_not have_content(review_1.rating)
      expect(page).to_not have_content(review_1.content)
      expect(page).to_not have_xpath("//img[contains(@src, '#{review_1.photo}')]")
    end
    within("#review-#{review_2.id}") do
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.rating)
      expect(page).to have_content(review_2.content)
      expect(page).to have_xpath("//img[contains(@src, '#{review_2.photo}')]")
    end
  end
end
