require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  before(:each) do
    @shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")
    @review = @shelter.reviews.create(title:    "Awesome place!",
                                    rating:   5,
                                    content:  "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                                    photo:    "https://i.imgur.com/c6SIBcM.jpg")
    @new_info = {title: "Bad place",
                rating: 1,
                content: "They said my fish was too aggressive to take in",
                photo: "https://i.imgur.com/c6SIBcM.jpg"}

    visit "/shelters/#{@shelter.id}"
    within("#review-#{@review.id}") do
      click_link "Edit Review"
    end
  end

  it "I can edit a review at '/shelters/:id'" do
    expect(page).to have_current_path("/reviews/#{@review.id}/edit")
    expect(page).to have_field(:title, with: @review.title)
    expect(page).to have_field(:rating, with: @review.rating)
    expect(page).to have_field(:content, with: @review.content)
    expect(page).to have_field(:photo, with: @review.photo)
  end

  it "I can update a review" do
    fill_in :title, with: @new_info[:title]
    fill_in :rating, with: @new_info[:rating]
    fill_in :content, with: @new_info[:content]
    fill_in :photo, with: @new_info[:photo]
    click_on "Edit Review"

    expect(page).to have_current_path("/shelters/#{@shelter.id}")

    within("#review-#{@review.id}") do
      expect(page).to have_content(@new_info[:title])
      expect(page).to have_content(@new_info[:rating])
      expect(page).to have_content(@new_info[:content])
      expect(page).to have_xpath("//img[contains(@src, '#{@new_info[:photo]}')]")
    end
  end

  it 'I can not update a review with an empty required field' do
    fill_in :title, with: @new_info[:title]
    fill_in :rating, with: ""
    fill_in :content, with: @new_info[:content]
    fill_in :photo, with: @new_info[:photo]
    click_on "Edit Review"

    expect(page).to have_current_path("/reviews/#{@review.id}")
    expect(page).to have_content("Review not updated: Required information missing.")
  end
end