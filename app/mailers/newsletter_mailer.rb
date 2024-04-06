class NewsletterMailer < ApplicationMailer
  def newsletter_email(newsletter)
    @newsletter = newsletter
    mail_to = Config.find_by(name: 'mail_to').value
    mail(to: mail_to, subject: 'Новая подписка')
  end
end
