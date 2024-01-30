class AddBreedAndDescriptionToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :breed, :string
    add_column :pets, :description, :text
  end
end
