class Favorites
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def count_of
    @contents.length
  end

  def add_pet(pet_id)
    @contents << pet_id.to_s
  end

  def been_favorited(pet_id)
    @contents.include?(pet_id)
  end

  def find_pet(pet_id)
    pet = Pet.find(pet_id.to_i)
  end

  def remove_pet(pet_id)
    @contents.delete(pet_id.to_s)
  end
end
