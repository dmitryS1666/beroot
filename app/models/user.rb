class User < ApplicationRecord
  has_many :products, dependent: :destroy

  def username
    return self.email.split('@')[0]
  end

  include Trestle::Auth::ModelMethods
  include Trestle::Auth::ModelMethods::Rememberable
end
