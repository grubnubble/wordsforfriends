class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def activate_email( user)
    @user = user
    @url = "http://example.com/users/activate/"+user.email_key
    mail :to => user.email, :subject => "Your activation link for Matt's thing."
  end

  def welcome_email( user)
    @user = user
    @url = "http://example.com/users/welcome/"
    mail :to => user.email, :subject => "Consider yourself 'activated'"
end
