class AdminMailer < ApplicationMailer
  def contact(email, message)
    @email = email
    @message = message
    mail to: 'admin@targetmvd.com',
         subject: I18n.t('api.mail.admin_mailer.contact.subject')
  end
end
