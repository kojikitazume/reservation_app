class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new

  end

  def create
    @room = Room.new(params.require(:room).permit(:name, :description, :price, :address, :image))
    @room.user_id = current_user.id
    if @room.save
      flash[:notice] = "施設を登録しました"
      redirect_to action: :show, id: @room.id
    else
      flash.now[:alert] = "施設を登録できませんでした"
      render action: :new
    end
  end

  def show
    @room = Room.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Room not found'
    redirect_to rooms_path
  end

  def posts
    @rooms = Room.where(user_id: current_user.id)
  end

  def search
    @rooms = Room.all
    if params[:area].present?
      @rooms = @rooms.where('address LIKE ?', "%#{params[:area]}%")
    end
    if params[:keyword].present?
      @rooms = @rooms.where('name LIKE ? OR description LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end