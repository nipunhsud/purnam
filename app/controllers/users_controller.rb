class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  layout "base"

  before_action :require_unauthentication, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url, notice: t(".welcome")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:email_address, :password, account_attributes: %i[id first_name last_name])
    end
end
