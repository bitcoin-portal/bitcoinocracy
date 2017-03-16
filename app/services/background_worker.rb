class BackgroundWorker

  def work
    Rails.logger.info "Background worker for #{root_url} started."
    @last_notified_at = 1.minute.ago
    loop do
      sleep(10) # don't DOS blockchain.info neither our database
      update_bitcoin_balance
      hide_old_arguments_without_signature
      notify_moderators_regarding_new_arguments
    end
  end

  def update_bitcoin_balance
    BitcoinAddress.unscoped.order("updated_at ASC").first.try(:update_balance)
  end

  def hide_old_arguments_without_signature
    Argument.visible.where('updated_at < ? and all_sum = 0', 3.hours.ago).each do |a|
      Rails.logger.info "Hiding argument #{a.slug}: #{a.statement}"
      a.hide!
      SlackNotifier.notify "The following proposition has been automatically hidden:\n"\
                           ">#{a.statement}\n"\
                           "[<a href='#{unhide_admin_argument_url(a)}'>Unhide</a>]"
    end
  end

  def notify_moderators_regarding_new_arguments
    Argument.visible.where('created_at > ?', @last_notified_at).each do |a|
      SlackNotifier.notify "New proposition:\n"\
                           ">#{a.statement}\n"\
                           "[<a href='#{hide_admin_argument_url(a)}'>Hide</a>]"
    end
    @last_notified_at = Time.now
  end

end
