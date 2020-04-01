require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  before(:each) do
    @shelter = Shelter.create(name:    "Dumb Friends League",
                             address: "2080 S. Quebec St.",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80231")

    @pet1 = @shelter.pets.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                                name:         "Kona",
                                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                                approx_age:   6,
                                sex:          "male",
                                status:       "adoptable")
    @pet2 = @shelter.pets.create(image:        "http://www.pngall.com/wp-content/uploads/4/Golden-Retriever-Puppy-PNG.png",
                                name:         "Max",
                                description:  "Max likes to eat all different types of food",
                                approx_age:   3,
                                sex:          "male",
                                status:       "adoptable")
    visit "/pets/#{@pet1.id}"
    click_link "Favorite Pet"

    visit "/pets/#{@pet2.id}"
    click_link "Favorite Pet"
    visit "/favorites"
  end

  it "I can see pets that have been favorited" do
    within("#pet-#{@pet1.id}") do
      expect(page).to have_content(@pet1.name)
      expect(page).to have_css("img[src*='#{@pet1.image}']")
    end

    within("#pet-#{@pet2.id}") do
      expect(page).to have_content(@pet2.name)
      expect(page).to have_css("img[src*='#{@pet2.image}']")
    end
  end

  it "I can remove a pet that has been favorited" do
    within("#pet-#{@pet1.id}") do
      click_link "Remove from favorites"
    end

    within("main") do
      expect(page).to have_no_content(@pet1.name)
      expect(page).to have_no_css("img[src*='#{@pet1.image}']")
    end

    within("#pet-#{@pet2.id}") do
      expect(page).to have_content(@pet2.name)
      expect(page).to have_css("img[src*='#{@pet2.image}']")
      expect(page).to have_content("Remove from favorites")
    end
  end

  it "will display a statement when there are no favorite pets" do
    click_link "Remove All Favorited Pets"
    expect(page).to have_content("You have no favorited pets")
  end

  it "I can see a list of pets that have applications on them" do
    application_info = {name:         "Rick Astley",
                        address:      "123 Wisteria Ln",
                        city:         "Denver",
                        state:        "CO",
                        zip:          "80202",
                        phone:        "123-4567",
                        description:  "I would make a great dog dad!"}

    click_link "Adopt Pets"
    select @pet1.name, from: :pets
    select @pet2.name, from: :pets
    fill_in :name, with: "name"
    fill_in :address, with: application_info[:address]
    fill_in :city, with: application_info[:city]
    fill_in :state, with: application_info[:state]
    fill_in :zip, with: application_info[:zip]
    fill_in :phone, with: application_info[:phone]
    fill_in :description, with: application_info[:description]
    click_button "Submit Application"

    within('#application-pets') do
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
      click_link @pet2.name
    end
    
    expect(page).to have_current_path("/pets/#{@pet2.id}")
  end
end
