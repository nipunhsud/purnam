class SlackService
    def initialize(user_token = nil)
      @client = Slack::Web::Client.new(token: user_token || Slack.config.token)
    end
  
    def post_message(channel, text, options = {})
      @client.chat_postMessage(channel: channel, text: text, **options)
    rescue Slack::Web::Api::Errors::SlackError => e
      Rails.logger.error("Slack API Error: #{e.message}")
    end
  
    def schedule_message(channel, text, post_at, options = {})
      @client.chat_scheduleMessage(channel: channel, text: text, post_at: post_at, **options)
    rescue Slack::Web::Api::Errors::SlackError => e
      Rails.logger.error("Slack API Error: #{e.message}")
    end
  
    def list_channels
      @client.conversations_list(types: 'public_channel').channels
    rescue Slack::Web::Api::Errors::SlackError => e
      Rails.logger.error("Slack API Error: #{e.message}")
      []
    end
  
    def list_private_channels
      @client.conversations_list(types: 'private_channel').channels
    rescue Slack::Web::Api::Errors::SlackError => e
      Rails.logger.error("Slack API Error: #{e.message}")
      []
    end
end
  