class SlackNotifier
  def self.notify(message)
    begin
      @notifier ||= Slack::Notifier.new ENV['SLACK_WEBHOOK_URL'] do
        defaults channel: ENV['SLACK_CHANNEL'],
                 username: ENV['SLACK_NAME']
      end
      @notifier.ping(message)
    rescue Exception => exception
      Rails.logger.warn("Failed notification: ('#{message}') with exception ('#{exception}')")
    end
  end
end
