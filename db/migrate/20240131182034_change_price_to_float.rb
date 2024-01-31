class ChangePriceToFloat < ActiveRecord::Migration[7.1]
  def change
    change_column :pets, :price, :float
  end
end
