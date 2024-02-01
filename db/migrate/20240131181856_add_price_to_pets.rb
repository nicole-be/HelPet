class AddPriceToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :price, :integer
  end
end
