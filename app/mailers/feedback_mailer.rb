class FeedbackMailer < ApplicationMailer
  def feedback_email(feedback)
    @feedback = feedback
    mail(to: 'agromaster.info@yandex.ru', subject: 'Новый вопрос')
  end
end
