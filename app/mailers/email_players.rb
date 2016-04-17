class EmailPlayers < ApplicationMailer
  
  def reset_password(player)
    
    @player = player
    @url  = "https://dnd-player-app-radben13.c9users.io/reset_password/#{@player.id}/#{@player.auth_token}"
    mail(to: @player.email, subject: 'Welcome to Role20')
  end
end
