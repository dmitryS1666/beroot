class Newsletter < ApplicationRecord
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "АгроМастер: Новая подписка",
      :to => "agromaster.info@yandex.ru",
      :from => %("#{email}")
    }
  end
end
