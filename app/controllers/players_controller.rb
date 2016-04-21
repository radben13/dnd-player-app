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
    @logging_player = Player.new
    @requesting_player = Player.new
    @new_player = Player.new(new_player_params)
    if @current_player
      logout
      flash.now[:error] = "You were logged in as #{@current_player.player_tag || @current_player.email}. You have been logged out and may try again to create an account."
      @new_player.password_digest = nil
      @new_player.password = nil
      @new_player.password_confirmation = nil
      render 'player_sessions/new'
    elsif @new_player.save
      EmailPlayers.activate_account(@new_player).deliver_now
      flash[:noticce] = "Your account has been successfully created! Try logging in now, or check your email for a link to activate your new account."
      redirect_to login_path
    else
      flash.now[:error] = "There was a problem saving your account."
      @new_player.password_digest = nil
      @new_player.password = nil
      @new_player.password_confirmation = nil
      render 'player_sessions/new'
    end
  end
  
  def new
    @logging_player = Player.new
    @new_player = Player.new
    render 'player_sessions/new'
  end
  
  def index
    if !@current_player.is_gm?
      flash[:error] = "You do not have permissions to view that page."
      redirect_to '/'
    end
    @players = Player.all.limit(50).offset(params[:page])
  end
  
  def activate
    if !@current_player
      flash[:notice] = "Login to complete account activation."
      session[:pending_path] = activate_player_path(params[:id])
      redirect_to login_path
    elsif @current_player.id.to_s != params[:id]
      logout
      flash[:error]  = "You were logged in as a different account. You are logged out now and may login to complete account activation."
      session[:pending_path] = activate_player_path(params[:id])
      redirect_to login_path
    elsif @current_player.update(:activated => "activated")
      flash[:notice] = "Your account has been activated!"
      redirect_to '/account'
    else
      flash[:error] = "There was an error activating your account. Contact us at #{ENV[GMAIL_USERNAME]} to help the issue be resolved."
      redirect_to root_path
    end
  end
  
  def show_json
    if @current_player
      render json: @current_player
    else
      render json: nil
    end
  end
  
  # NEW PASSWORD
  
  def request_password
    email_params = params.require(:player).permit(:email)
    @requesting_player = Player.where(email_params).take
  end
  
  def new_password
    @player = Player.find(params[:id])
    if !@player
      flash[:error] = "That link isn't valid."
      redirect_to root_path
    elsif @player.auth_token != params[:auth_token]
      flash[:error] = "That link isn't valid or has expired."
      redirect_to root_path
    end
  end
  
  def reset_password
    @player = Player.find(params[:id])
    if !@player || @player.auth_token != params[:player][:auth_token]
      flash[:error]  = "That form was invalid."
      redirect_to root_path
    elsif @player.update(reset_password_params) && @player.regenerate_auth_token
      EmailPlayers.alert_email(@player, {
        subject: "Lore20 - Your Password Has Been Changed",
        messages: [
            "Your Lore20 password has been changed. This change was official at #{Time.now}",
            "If you did not do or request this change, your email may be compromised."
          ]
      })
      flash[:notice] = "You have successfully changed your password. You may now login as #{@player.player_tag || @player.email}"
      redirect_to login_path
    else
      @player.password = nil
      @player.password_confirmation = nil
      render :new_password
    end
  end
  
  protected
  
  def reset_password_params
    params.require(:player).permit(:password, :password_confirmation)
  end
  
  def new_player_params
    params.require(:player).permit(:email, :player_tag, :password, :password_confirmation)
  end
end