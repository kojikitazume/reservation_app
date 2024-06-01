class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show]
  before_action :set_room

  def index
    @reservations = current_user.reservations
    @reservations = @room.reservations
  end

  def new
    @reservation = Reservation.new
    @reservation.check_in_date = params[:check_in_date]
    @reservation.check_out_date = params[:check_out_date]
    @reservation.number_of_guests = params[:number_of_guests]
    @reservation.room_id = params[:room_id]
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id

    if @reservation.save
      redirect_to reservations_path, notice: '予約が完了しました'
    else
      render :new
    end
  end
  
  def show
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Reservation not found'
    redirect_to reservations_path
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_guests, :room_id)
  end

  def set_room
  @room = Room.find_by(id: params[:room_id])
  unless @room
    flash[:alert] = 'Room not found'
    redirect_to root_path
  end
end
end
