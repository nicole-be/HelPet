class PetsController < ApplicationController
  before_action :set_pet, only: [:show]

  def index
    @pets = Pet.all
    @pets_count = @pets.count

    @markers = @pets.map do |pet|
      {
        lat: pet.user.latitude,
        lng: pet.user.longitude,
        info_window_html: render_to_string(partial: "info_pets", locals: {pet: pet})
      }
    end

    if params.dig(:query).present?
      @pets = Pet.global_search(params[:query])

    end
  end

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
      render :new, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :description, photos: [])
  end

  def set_pet
    @pet = Pet.find(params[:id])
  end
end
