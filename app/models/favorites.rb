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
end