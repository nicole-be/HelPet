class BookingsController < ApplicationController
  before_action :set_pet, only: [:index, :new, :create]
  before_action :set_booking, only: [:update]

  def index
    @owner = @pet.user
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.pet = @pet
    @booking.user = current_user

    if @booking.save
      redirect_to pet_bookings_path(@pet)
    else
      render "pets/show", status: :unprocessable_entity # that was heavy
    end
  end

  def update
    @booking.status = params[:status]
    if @booking.save
      redirect_to pet_booking_path(@booking.pet)
    elsif
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
