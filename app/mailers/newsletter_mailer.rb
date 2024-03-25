class NewsletterMailer < ApplicationMailer
  def newsletter_email(newsletter)
    @newsletter = newsletter
    mail(to: 'agromaster.info@yandex.ru', subject: 'Новая подписка')
  end
end
