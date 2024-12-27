class SlackController < ApplicationController
    def oauth_callback
      code = params[:code]
      uri = URI.parse('https://slack.com/api/oauth.v2.access')
      response = Net::HTTP.post_form(uri, {
        client_id: ENV['SLACK_CLIENT_ID'],
        client_secret: ENV['SLACK_CLIENT_SECRET'],
        code: code,
        redirect_uri: ENV['SLACK_REDIRECT_URI']
      })
      data = JSON.parse(response.body)
  
      if data['ok']
        session[:slack_access_token] = data['authed_user']['access_token']
        flash[:notice] = "Slack integration successful for user ID #{data['authed_user']['id']}!"
        redirect_to root_path
      else
        flash[:alert] = "Slack OAuth failed: #{data['error']}"
        redirect_to root_path
      end
    end
  end
  
  