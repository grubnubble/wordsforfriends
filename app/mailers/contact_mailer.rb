class ContactMailer < ActionMailer::Base
  default from: "someone@somewhere.com"

  def contact_email( email)
    @email = email
    mail(
      :from => @email[:from][:address],
      :to => "logical.zero@gmail.com", 
      :subject => @email[:subject],
      :message => @email[:message] 
    )
  end
end
