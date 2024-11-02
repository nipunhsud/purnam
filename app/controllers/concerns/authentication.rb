# Authentication Module - Created from Rails generators.
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication

    helper_method :authenticated?, :unauthenticated?, :current_user, :current_account
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def current_user
      @current_user ||= resume_session && Current.user
    end

    def current_account
      @current_account ||= current_user && current_user.account
    end

    def authenticated?
      current_account.present?
    end

    def unauthenticated?
      !authenticated?
    end

    def require_authentication
      resume_session || request_authentication
    end

    def require_unauthentication
      redirect_back fallback_location: projects_path if authenticated?
    end

    def resume_session
      Current.session = find_session_by_cookie
    end

    def find_session_by_cookie
      Session.find_by(id: cookies.signed[:session_id])
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url
      redirect_to new_session_url
    end

    def after_authentication_url
      session.delete(:return_to_after_authenticating) || projects_path
    end

    def start_new_session_for(user)
      user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
        Current.session = session
        cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
      end
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
    end
end