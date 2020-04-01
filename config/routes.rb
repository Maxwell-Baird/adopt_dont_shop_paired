Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Welcome
  get '/', to: 'welcome#index'

  # Shelters
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'

  post '/shelters', to: 'shelters#create'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  # Pets
  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'

  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  # Shelter Pets
  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'shelter_pets#new'

  post '/shelters/:shelter_id/pets', to: 'shelter_pets#create'

  # Reviews
  get '/reviews/:id/edit', to: 'reviews#edit'

  patch '/reviews/:id', to: 'reviews#update'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id', to: 'reviews#create'
  delete '/shelters/:shelter_id/reviews/:id', to: 'reviews#destroy'

  # Favorites
  get '/favorites', to: 'favorites#index'

  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites', to: 'favorites#destroy'
  delete '/favorites/:pet_id', to: 'favorites#destroy'

  # Applications
  get '/applications/new', to: 'applications#new'
  get '/applications/:id', to: 'applications#show'

  post '/applications', to: 'applications#create'

  get 'pets/:id/applications', to: 'pets#applications'
  patch '/applications/:id/pets/:pet', to: 'applications#status'
  put '/applications/:id/pets/:pet', to: 'applications#revoke'

  patch 'applications/:application_id/:pet_id', to: 'applications#update'
  patch '/applications/:application_id', to: 'applications#update'
end
