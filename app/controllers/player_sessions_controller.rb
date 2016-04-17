class PlayerSessionsController < ApplicationController
  
  skip_before_filter :clear_pending_path, :only => [:create, :new]
  
  
  def new
    if @current_player
      flash.now[:error] = "You are already logged in as #{@current_player.player_tag || @current_player.email}. Logging into a different account will logout."
    end
    @logging_player = Player.new
  end
  
  def create
    if @current_player
      logout
    end
    player = Player.where(:email => sign_in_params[:email]).take.authenticate(sign_in_params[:password])
    if player
      @player_session = PlayerSession.create(player_id: player.id, session_id: session[:session_id])
      @current_player = player
      session[:player_id] = player.id
      flash[:notice] = "You have successfully logged in as #{@current_player[:player_tag] || @current_player[:email]}."
      pending_path = session[:pending_path]
      session[:pending_path] = nil
      redirect_to pending_path || root_path
    else
      @logging_player = Player.new(:email => params[:player][:email])
      flash.now[:error] = "That email and password did not match."
      render :new
    end
  end
  
  def delete
    if @player_session
      logout
      flash[:notice] = "Successfully logged out."
    else
      flash[:error] = "Logging out is silly when you're not logged in."
    end
    redirect_to root_path
  end
  
  protected
  
  def sign_in_params
    params.require(:player).permit(:email, :password)
  end
  
  def logout
    @player_session.destroy
    @current_player = nil
    reset_session
  end
end