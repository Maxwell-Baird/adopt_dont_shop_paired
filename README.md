# Adopt Don't Shop

"Adopt Don't Shop" is an exercise in building a Ruby on Rails app to manage adoption shelters, pets, favorite pets, and applications. It was created by Turing School students Maxwell Baird and Alex Latham.

## Production App
The app is hosted at http://morning-shore-43791.herokuapp.com/

## Local App Setup
Please ensure you are running Ruby 2.6.x with Rails 5.1.x and then run the following commands:
```
git clone git@github.com:Maxwell-Baird/adopt_dont_shop_paired.git
cd adopt_dont_shop_paired
bundle install
rails db:{create,migrate,seed}
rails s
```
Once the rails server is running, open your browser and navigate to http://localhost:3000/