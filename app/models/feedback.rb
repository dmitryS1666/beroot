class Feedback < ApplicationRecord
  attribute :name, validate: true
  attribute :last_name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :phone, validate: true
  attribute :message, validate: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "АгроМастер: Новый запрос",
      :to => "agromaster.info@yandex.ru",
      :from => %("#{name}" <#{email}>)
    }
  end
end
