class EmailPlayers < ApplicationMailer
  
  def reset_password(player)
    @player = player
    @url  = "https://dnd-player-app-radben13.c9users.io/players/#{@player.id}/reset_password/#{@player.auth_token}"
    mail(to: @player.email, subject: 'Lore20 - Reset Password')
  end
  
  def activate_account(player)
    @player = player
    @url = "https://dnd-player-app-radben13.c9users.io/players/#{@player.id}/activate"
    mail(to: @player.email, subject: "Welcome to Lore20")
  end
  
  def alert_email(player, email_content)
    @player = player
    @messages = email_content[:messages]
    @subject = email_content[:subject]
    mail(to: @player.email, subject: @subject)
  end
end
