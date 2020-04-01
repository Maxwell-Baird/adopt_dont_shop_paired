class AddApprovedForToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :approved_for, :string
  end
end
