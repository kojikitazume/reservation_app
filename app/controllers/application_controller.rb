class ApplicationController < ActionController::Base
    before_action :set_current_room
  
    private
  
    def set_current_room
      @room = Room.first 
    end
  end
