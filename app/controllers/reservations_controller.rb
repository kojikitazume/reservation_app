class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :confirm, :update]
  before_action :set_room, only: [:new, :create]

  def index
    @reservations = Reservation.where(user_id: current_user.id)
  end

  def new
    @reservation = Reservation.new
    @reservation.check_in_date = params[:check_in_date]
    @reservation.check_out_date = params[:check_out_date]
    @reservation.number_of_guests = params[:number_of_guests]
    @reservation.room_id = params[:room_id]
    @reservation.user_id = current_user.id
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    
    if @reservation.save
      flash[:notice] = "施設の予約が完了しました"
      redirect_to confirm_reservation_path(@reservation)
    else
      flash.now[:alert] = "予約の保存に失敗しました"
      render "new"
    end
  end

  def confirm
    @reservation = Reservation.find(params[:id])
  end

  def update
    if @reservation.update(reservation_params)
      flash[:notice] = "予約が確定しました"
      redirect_to reservations_path
    else
      flash.now[:alert] = "予約の確定に失敗しました"
      render "confirm"
    end
  end

  def show
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_guests, :room_id, :days, :total_price)
  end

  def set_room
    room_id = params[:room_id] || params.dig(:reservation, :room_id)
    @room = Room.find_by(id: room_id)
    unless @room
      flash[:alert] = 'Room not found'
      redirect_to root_path
    end
  end
end


