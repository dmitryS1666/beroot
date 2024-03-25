class NewslettersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = Newsletter.new(feedback_params)
    @newsletter[:created_at] = Time.zone.now

    if @newsletter.save
      NewsletterMailer.newsletter_email(@newsletter).deliver_now
      redirect_to root_path, notice: 'Спасибо за подписку!'
    else
      render :new
    end
  end

  private

  def feedback_params
    params.permit(:email)
  end
end
