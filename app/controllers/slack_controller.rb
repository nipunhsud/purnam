class SlackController < ApplicationController
    def oauth_callback
      auth = request.env['omniauth.auth']
  
      user_token = auth['credentials']['token']
      user_name = auth['info']['user']
  
      session[:slack_access_token] = user_token
  
      flash[:notice] = "Slack integration successful for #{user_name}!"
      redirect_to root_path
    end
end
  