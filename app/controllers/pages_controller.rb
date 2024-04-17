class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def about
    @about_slider = AboutSlider.all
  end

  def contact; end

  def pay; end

  def delivery; end

  def privacy_policy; end
end
