class AddNamesAndRoleAndDescAndAddrToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :string
    add_column :users, :description, :text
    add_column :users, :address, :string
  end
end
