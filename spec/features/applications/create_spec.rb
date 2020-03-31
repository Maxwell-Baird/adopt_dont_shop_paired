require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  xit "I can apply to adopt my favorite pets" do
    shelter1 = Shelter.create(name:    "Dumb Friends League",
                              address: "2080 S. Quebec St.",
                              city:    "Denver",
                              state:   "CO",
                              zip:     "80231")
    shelter2 = Shelter.create(name:     "MaxFund Animal Adoption Center",
                              address:  "1005 Galapago St.",
                              city:     "Denver",
                              state:    "CO",
                              zip:      "80204")
    pet_1 = shelter1.pets.create(image:       "https://i.imgur.com/9AyaA0q.jpg",
                                name:         "Kona",
                                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                                approx_age:   6,
                                sex:          "male",
                                status:       "adoptable")
    pet_2 = shelter1.pets.create(image:       "http://www.pngall.com/wp-content/uploads/4/Golden-Retriever-Puppy-PNG.png",
                                name:         "Max",
                                description:  "Max likes to eat all different types of food",
                                approx_age:   3,
                                sex:          "male",
                                status:       "adoptable")
    pet_3 = shelter2.pets.create(image:       "https://i.imgur.com/2M5NPna.jpg",
                                name:         "Molly",
                                description:  "Hi, everybody! Did you know that Molly means 'star of the sea?' This Molly here may soon mean 'star of your life!' If you like the sound of that, let me tell you more about myself. You will love what you hear! I'm a super sweet, 11-year-old Australian Cattle Dog female. I am an adorable, medium-sized girl weighing about 35 lbs. What a great size, don't you think?",
                                approx_age:   11,
                                sex:          "female",
                                status:       "adoptable")
    application_info = {name: "Rick Astley",
                        address:      "123 Wisteria Ln",
                        city:         "Denver",
                        state:        "CO",
                        zip:          "80202",
                        phone:        "123-4567",
                        description:  "I would make a great dog dad!"}


    visit "/pets/#{pet_1.id}"
    click_link "Favorite Pet"
    visit "/pets/#{pet_2.id}"
    click_link "Favorite Pet"
    visit "/pets/#{pet_3.id}"
    click_link "Favorite Pet"
    visit "/favorites"
    click_link "Adopt Pets"

    expect(page).to have_current_path("/applications/new")

    select "Kona", from: :pets
    select "Molly", from: :pets
    fill_in :name, with: application_info[:name]
    fill_in :address, with: application_info[:address]
    fill_in :city, with: application_info[:city]
    fill_in :state, with: application_info[:state]
    fill_in :zip, with: application_info[:zip]
    fill_in :phone, with: application_info[:phone]
    fill_in :description, with: application_info[:description]
    click_button "Submit Application"

    expect(page).to have_content("Your application has been submitted")
    expect(page).to have_current_path("/favorites")
    within("#favorites") do
      expect(page).to have_content("Favorites: 1")
    end
    expect(page).to have_content(pet2.name)
    expect(page).to_not have_content(pet1.name)
    expect(page).to_not have_content(pet3.name)
  end
end