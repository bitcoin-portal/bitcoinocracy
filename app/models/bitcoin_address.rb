require 'net/http'
class BitcoinAddress < ActiveRecord::Base
  default_scope { order('balance DESC, bitcoin_address ASC') }

  has_many :signatures
  has_many :arguments, through: :signatures

  def self.fetch_balance bitcoin_address
    request_balance("https://blockdozer.com/insight-api/addr/#{bitcoin_address}/balance") ||
    request_balance("https://bitcoincash.blockexplorer.com/api/addr/#{bitcoin_address}/balance")
  end

  def update_balance
    if new_balance
      if (new_balance.to_i >= 0) and (new_balance != self.balance)
        logger.info "new balance for #{bitcoin_address}: #{new_balance}"
        update_attribute :balance, new_balance
        arguments.each{|a|a.update_validity}
      else
        touch :updated_at # push it to the end of the queue
      end
    else
      logger.warn "failed to retrieve balance for bitcoin address #{bitcoin_address}"
    end
  end

  def to_s
    bitcoin_address
  end

private

  def new_balance
    @new_balance ||= self.class.fetch_balance(bitcoin_address)
  end

  def self.request_balance url
    (Integer(Net::HTTP.get(URI.parse(url))) rescue false)
  end

end
