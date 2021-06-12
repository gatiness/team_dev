class AssignMailer < ApplicationMailer
  default from: 'from@example.com'

  def assign_mail(email, password)
    @email = email
    @password = password
    mail to: @email, subject: I18n.t('views.messages.complete_registration')
  end
  def delete_agenda_mail(users)
    @email = users.pluck(:email)
    mail to: @email.split(","), subject: I18n.t('views.messages.complete_registration')   
  end
  def changed_owner_mail(email)
    mail to: email, subject: I18n.t('views.messages.complete_registration') 
  end
end
