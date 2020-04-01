class RemoveApprovedForFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :approved_for, :string
  end
end
