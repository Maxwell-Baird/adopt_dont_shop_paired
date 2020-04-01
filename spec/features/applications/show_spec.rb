require 'rails_helper'

RSpec.describe "As a visitor" do
  before(:each) do
    shelter = Shelter.create(name:    "Dumb Friends League",
                              address: "2080 S. Quebec St.",
                              city:    "Denver",
                              state:   "CO",
                              zip:     "80231")
    @pet1 = shelter.pets.create(image:       "https://i.imgur.com/9AyaA0q.jpg",
                                name:         "Kona",
                                description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                                approx_age:   6,
                                sex:          "male",
                                status:       "adoptable")
    @pet2 = shelter.pets.create(image:       "http://www.pngall.com/wp-content/uploads/4/Golden-Retriever-Puppy-PNG.png",
                                name:         "Max",
                                description:  "Max likes to eat all different types of food",
                                approx_age:   3,
                                sex:          "male",
                                status:       "adoptable")
    application_info = {name:         "Rick Astley",
                        address:      "123 Wisteria Ln",
                        city:         "Denver",
                        state:        "CO",
                        zip:          "80202",
                        phone:        "123-4567",
                        description:  "I would make a great dog dad!"}

    visit "/pets/#{@pet1.id}"
    click_link "Favorite Pet"
    visit "/pets/#{@pet2.id}"
    click_link "Favorite Pet"
    click_link "Favorites: 2"
    click_link "Adopt Pets"
    select @pet1.name, from: :pets
    select @pet2.name, from: :pets
    fill_in :name, with: application_info[:name]
    fill_in :address, with: application_info[:address]
    fill_in :city, with: application_info[:city]
    fill_in :state, with: application_info[:state]
    fill_in :zip, with: application_info[:zip]
    fill_in :phone, with: application_info[:phone]
    fill_in :description, with: application_info[:description]
    click_button "Submit Application"

    @application = Application.first
  end

  it "I can visit an applications show page" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Name: #{@application.name}")
    expect(page).to have_content("Address: #{@application.address}")
    expect(page).to have_content("City: #{@application.city}")
    expect(page).to have_content("State: #{@application.state}")
    expect(page).to have_content("Zip: #{@application.zip}")
    expect(page).to have_content("Phone: #{@application.phone}")
    expect(page).to have_content("Description: #{@application.description}")
    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
  end
end