class FeedbackMailer < ApplicationMailer
  def feedback_email(feedback)
    @feedback = feedback
    mail_to = Config.find_by(name: 'mail_to').value
    mail(to: mail_to, subject: 'Новый вопрос')
  end
end
