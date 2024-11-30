class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  before_action :require_unauthentication, only: %i[new create]

  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  def new
    render layout: "base"
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url, notice: t(".welcome")
    else
      redirect_to new_session_path, alert: t(".try_again")
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, notice: t(".logged_out")
  end
end
