class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :verify_session
  before_filter :clear_pending_path
  
  
  protected
  
  def clear_pending_path
    session[:pending_path] = nil;
  end
  
  def verify_session
    session_id = session[:session_id]
    @current_player = nil
    @player_session = PlayerSession.where(:session_id => session_id)
    @player_session = @player_session.take
    if @player_session
      if @player_session.created_at < 5.days.ago
        @player_session.destroy
      elsif session[:player_id] && session[:player_id] == @player_session[:player_id]
        @current_player = Player.find(session[:player_id])
        return true
      end
      reset_session
    end
    return false
  end
  
  def logout
    @player_session.destroy
    @current_player = nil
    reset_session
  end
  
  def require_current_player
    if !@current_player
      session[:pending_path] = request.fullpath
      flash[:error] = "You are not signed in."
      redirect_to login_path
    end
  end
  
  def require_gm
    if @current_player && !@current_player.is_gm?
      session[:pending_path] = request.fullpath
      flash[:error] = "You do not have permission to view that page."
      redirect_to root_path
    end
  end
  
  def require_dm
    if @current_player && !@current_player.is_dm?
      session[:pending_path] = request.fullpath
      flash[:error] = "You do not have permission to view that page."
      redirect_to root_path
    end
  end
end
