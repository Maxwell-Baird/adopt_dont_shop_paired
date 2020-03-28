require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can delete all favorites at /favorites" do

    shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    pet1 = shelter.pets.create(image:       "https://i.imgur.com/9AyaA0q.jpg",
                              name:         "Kona",
                              description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                              approx_age:   6,
                              sex:          "male",
                              status:       "adoptable")
    pet2 = shelter.pets.create(image:       "https://i.imgur.com/sS9UGFN.jpg",
                              name:         "Benji",
                              description:  "Benji is a wonderful boy with a great smile! He loves his people and is happiest by their side. In the past, he spent most of his time in the yard and was crated at night indoors. This has given him little chance of socialization outside of his home and family. Like many dogs, being in a shelter can be scary. This is especially true for dogs like Benji, who have never left their property.",
                              approx_age:   2,
                              sex:          "male",
                              status:       "pending adoption")
    Favorites.new([pet1.id.to_s,pet2.id.to_s])

    visit "/favorites"

    within('#favorites') do
      expect(page).to have_content("Favorites: 2")
    end

    click_link "Remove All Favorited Pets"

    expect(page).to have_current_path("/favorites")
    expect(page).to have_content("You have no favorited pets")
    within('#favorites') do
      expect(page).to have_content("Favorites: 0")
    end
  end
end