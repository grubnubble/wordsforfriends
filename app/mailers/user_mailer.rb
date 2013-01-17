class UserMailer < ActionMailer::Base
  default from: "no-reply@wordsforfriends.com"

  def activate_email( user)
    @user = user
    @url = url_for :controller => "users", :action => "activate", :e_k => user.email_key
    mail :to => user.email, :subject => "Your activation link for Matt's thing."
  end

  def welcome_email( user)
    @user = user
    @url = url_for :controller => "sessions", :action => "new" 
    mail :to => user.email, :subject => "Consider yourself 'activated.'"
  end
end
