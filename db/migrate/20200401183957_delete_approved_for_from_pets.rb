class DeleteApprovedForFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :approved_for
  end
end
