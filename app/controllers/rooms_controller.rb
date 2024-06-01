class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    if params[:address]
      @rooms = @rooms.where('address LIKE(?)', "%#{params[:address]}%")
    end
    if params[:keyword]
      @rooms = @rooms.where('name LIKE(?)', "%#{params[:keyword]}%")
    end
  end
  def new
    @room = Room.new

  end

  def create
    @room = Room.new(params.require(:room).permit(:name, :introduce, :price, :address, :image))
    @room.user_id = current_user.id
    if @room.save
      redirect_to action: :show, id: @room.id
    else
      render action: :new
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def posts
    @rooms = Room.where(user_id: current_user.id)
  end
end
