class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :create, :index]

  def index
    @reservations = @room.reservations
  end

  def new
    @reservation = @room.reservations.build
  end

  def create
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to room_reservations_path(@room), notice: '予約が確定しました。'
    else
      render :new
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out)
  end
end
