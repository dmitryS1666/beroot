class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def about; end

  def contact; end

  def pay; end

  def delivery; end

  def privacy_policy; end
end
