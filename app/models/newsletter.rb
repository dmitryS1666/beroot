class Newsletter < ApplicationRecord
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "BEROOT: Новая подписка",
      :to => "beroot.info@yandex.ru",
      :from => %("#{email}")
    }
  end
end
