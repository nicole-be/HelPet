class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :create]

  def show
    @booking = Booking.new
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    if @pet.save
      redirect_to pet_path(@pet)
    else
      render :new
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :age, :price, :description, :photo)
  end

  def set_pet
    @pet = Pet.find(params[:id])
  end
end
