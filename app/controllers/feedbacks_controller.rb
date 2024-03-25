class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback[:created_at] = Time.zone.now

    if @feedback.save
      FeedbackMailer.feedback_email(@feedback).deliver_now
      redirect_to root_path, notice: 'Спасибо! Ваше сообщение очень важно для нас!'
    else
      render :new
    end
  end

  private

  def feedback_params
    params.permit(
      :name,
      :last_name,
      :phone,
      :email,
      :message
    )
  end
end
