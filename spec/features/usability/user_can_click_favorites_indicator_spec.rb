require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'I can click the favorites indicator and be taken to /favorites' do
    visit '/'
    click_link 'Favorites: 0'
    expect(page).to have_current_path('/favorites')
  end
end