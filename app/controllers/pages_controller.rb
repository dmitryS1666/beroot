class PagesController < ApplicationController
  include MainCategoryHelper
  skip_before_action :authenticate_user!
  before_action :set_main_category

  def about
    @contact = Contact.new
  end

  def contact; end
  def pay; end
  def delivery; end
end
