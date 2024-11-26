class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization
  include Turbo::Extensions

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def pundit_user
    current_account
  end
end
