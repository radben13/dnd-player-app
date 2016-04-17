class PlayersController < ApplicationController
  def show
    require_current_player
    if params[:id]
      @player = Player.find(params[:id])
    else
      @player = @current_player
    end
    # if @current_player && @player != @current_player && !@current_player.is_gm?
    #   flash[:error] = "You do not have permission to view that page."
    #   session[:pending_path] = request.fullpath
    #   redirect_to root_path
    # end
    # if !@current_player
    #   session[:pending_path] = request.fullpath
    #   flash[:error] = "You are not signed in."
    #   redirect_to login_path
    # end
  end
  
  def create
  end
  
  def new
  end
  
  def index
    if !@current_player.is_gm?
      flash[:error] = "You do not have permissions to view that page."
      redirect_to '/'
    end
    @players = Player.all.limit(50).offset(params[:page])
  end
  
  def show_json
    if @current_player
      render json: @current_player
    else
      render json: nil
    end
  end
end