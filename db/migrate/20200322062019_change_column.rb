class ChangeColumn < ActiveRecord::Migration[5.1]
  def up
    change_column_default :pets, :status, "adoptable"
  end

  def down
    change_column_default :pets, :status, nil
  end
end
