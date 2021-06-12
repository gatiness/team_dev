class AssignMailer < ApplicationMailer
  default from: 'from@example.com'

  def assign_mail(email, password)
    @email = email
    @password = password
    mail to: @email, subject: I18n.t('views.messages.complete_registration')
  end
  # def assign_mail(email, password)
  #   @email = email
  #   @password = password
  #   mail to: @email, subject: I18n.t('views.messages.complete_registration')
  # end
  def assign_mail(users)

    @email = users.pluck(users)

    mail to : @email.split(","), subject: I18n.t('views.messages.complete_registration')
end