class BitcoinPrice < ActiveRecord::Base
  def self.get
    Rails.cache.fetch("#{cache_key}/bitcoin_price", expires_in: 10.minutes) do
      self.fetch
    end
  end

  def self.fetch
    self.fetch_from_bitcoin_average || self.fetch_from_coindesk
  end

  def self.fetch_from_bitcoin_average
    logger.info "Fetching price from bitcoin average..."
    r = Net::HTTP.get(URI.parse('https://apiv2.bitcoinaverage.com/indices/global/ticker/BCHUSD'))
    Float(JSON.parse(r)['last']) rescue nil
  end

  def self.fetch_from_coinmarketcap
    logger.info "Fetching price from coinmarketcap..."
    r = Net::HTTP.get(URI.parse('https://api.coinmarketcap.com/v1/ticker/bitcoin-cash/'))
    Float(JSON.parse(r)['price_usd']) rescue nil
  end

  def self.cache_key
    'bchusd'
  end

end
