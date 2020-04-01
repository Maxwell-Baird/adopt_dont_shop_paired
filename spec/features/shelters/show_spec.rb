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

  it "I can see shelter statistics" do
    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")
    shelter.reviews.create(title:    "Awesome place!",
                                     rating:   5,
                                     content:  "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                                     photo:    "https://i.imgur.com/c6SIBcM.jpg")
    shelter.reviews.create(title:    "ok place!",
                                     rating:   3,
                                     content:  "Cute animals!")
    pet1 = shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                               name:         "Kona",
                               description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                               approx_age:   6,
                               sex:          "male",
                               status:       "adoptable")
    pet2 = shelter.pets.create(image:        "http://www.pngall.com/wp-content/uploads/4/Golden-Retriever-Puppy-PNG.png",
                               name:         "Max",
                               description:  "Max likes to eat all different types of food",
                               approx_age:   3,
                               sex:          "male",
                               status:       "adoptable")
    pet1.applications.create(name:         "Rick Astley",
                             address:      "123 Wisteria Ln",
                             city:         "Denver",
                             state:        "CO",
                             zip:          "80202",
                             phone:        "123-4567",
                             description:  "I would make a great dog dad!")
    pet_count = shelter.pets.length
    average_rating = shelter.reviews.sum {|review| review.rating }.fdiv(shelter.reviews.length)
    application_count = shelter.pets.joins(:applications).length

    visit "/shelters/#{shelter.id}"

    within('#statistics') do
      expect(page).to have_content("Count of Pets: #{pet_count}")
      expect(page).to have_content("Average Rating: #{average_rating}")
      expect(page).to have_content("Applications: #{application_count}")
    end
  end

end