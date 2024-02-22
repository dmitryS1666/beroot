class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about]

  def about
    @contact = Contact.new
  end

  def contact; end
  def pay; end
  def delivery; end
end
