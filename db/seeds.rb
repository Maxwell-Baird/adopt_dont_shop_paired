# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter1 = Shelter.create(name:     "Dumb Friends League",
                          address:  "2080 S. Quebec St.",
                          city:     "Denver",
                          state:    "CO",
                          zip:      "80231")
shelter2 = Shelter.create(name:     "Denver Animal Shelter",
                          address:  "1241 W. Bayaud Ave.",
                          city:     "Denver",
                          state:    "CO",
                          zip:      "80223")
shelter3 = Shelter.create(name:     "MaxFund Animal Adoption Center",
                          address:  "1005 Galapago St.",
                          city:     "Denver",
                          state:    "CO",
                          zip:      "80204")
shelter4 = Shelter.create(name:     "Foothills Animal Shelter",
                          address:  "580 McIntyre St.",
                          city:     "Golden",
                          state:    "CO",
                          zip:      "80401")

pet1 = Pet.create(image:        "https://i.imgur.com/9AyaA0q.jpg",
                  name:         "Kona",
                  description:  "Kona greets everyone with the biggest smile! He's always happy and is so easy to fall in love with. He seems to love everyone he meets, but can get a little overly excited some times and may knock little kids down. He is reportedly housebroken and does well when left alone in the home. He would benefit from daily walks and lots of playtime!",
                  approx_age:   6,
                  sex:          "male",
                  status:       "adoptable",
                  shelter_id:   shelter1.id)
pet2 = Pet.create(image:        "https://i.imgur.com/sS9UGFN.jpg",
                  name:         "Benji",
                  description:  "Benji is a wonderful boy with a great smile! He loves his people and is happiest by their side. In the past, he spent most of his time in the yard and was crated at night indoors. This has given him little chance of socialization outside of his home and family. Like many dogs, being in a shelter can be scary. This is especially true for dogs like Benji, who have never left their property.",
                  approx_age:   2,
                  sex:          "male",
                  status:       "pending adoption",
                  shelter_id:   shelter1.id)
pet3 = Pet.create(image:        "https://i.imgur.com/2M5NPna.jpg",
                  name:         "Molly",
                  description:  "Hi, everybody! Did you know that Molly means 'star of the sea?' This Molly here may soon mean 'star of your life!' If you like the sound of that, let me tell you more about myself. You will love what you hear! I'm a super sweet, 11-year-old Australian Cattle Dog female. I am an adorable, medium-sized girl weighing about 35 lbs. What a great size, don't you think?",
                  approx_age:   11,
                  sex:          "female",
                  status:       "adoptable",
                  shelter_id:   shelter3.id)
pet4 = Pet.create(image:        "https://i.imgur.com/I7tu1MA.jpg",
                  name:         "Pearl",
                  description:  "Hey there - my name is Pearl. Some people call me 'Miss Pearl' or 'Pearly Girl', but I pretty much know my name by now, so I will respond to any of those! I'm told that 'pearls' are known to attract wealth and luck. Well I don't know about the wealth part, but my luck sure turned around when I came to MaxFund back in April of 2019.",
                  approx_age:   12,
                  sex:          "female",
                  status:       "pending adoption",
                  shelter_id:   shelter3.id)