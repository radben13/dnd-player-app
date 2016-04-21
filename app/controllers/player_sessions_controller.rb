class PlayerSessionsController < ApplicationController
  
  skip_before_filter :clear_pending_path, :only => [:create, :new]
  
  
  def new
    if @current_player
      flash.now[:error] = "You are already logged in as #{@current_player.player_tag || @current_player.email}. Logging into a different account will logout."
    end
    @logging_player = Player.new
    @new_player = Player.new
    @requesting_player = Player.new
  end
  
  def create
    if @current_player
      logout
    end
    player = Player.where(:email => sign_in_params[:email]).take
    if !player
      @logging_player = Player.new(:email => params[:player][:email])
      @new_player = Player.new
      @requesting_player = Player.new
      flash.now[:error] = "No accounts match that player email."
      render :new
    elsif player.authenticate(sign_in_params[:password])
      @player_session = PlayerSession.create(player_id: player.id, session_id: session[:session_id])
      @current_player = player
      session[:player_id] = player.id
      flash[:notice] = "You have successfully logged in as #{@current_player[:player_tag] || @current_player[:email]}."
      redirect_to session[:pending_path] || root_path
    else
      @logging_player = Player.new(:email => params[:player][:email])
      @new_player = Player.new
      @requesting_player = Player.new
      flash.now[:error] = "That email and password did not match."
      render :new
    end
  end
  
  def delete
    if @player_session
      logout
      flash[:notice] = "Successfully logged out."
    else
      flash[:error] = "You weren't logged in."
    end
    redirect_to root_path
  end
  
  protected
  
  def sign_in_params
    params.require(:player).permit(:email, :password)
  end
  
end