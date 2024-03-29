class UserMailer < ActionMailer::Base
  default from: "noreply@project-sought.heroku.com"

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(:to => user.email,
         :subject => "Your password has been reset")
  end
end
