class BitcoinPrice < ActiveRecord::Base
  def self.get
    Rails.cache.fetch("#{cache_key}/bitcoin_price", expires_in: 10.minutes) do
      self.fetch
    end
  end

  def self.fetch
    self.fetch_from_bitcoin_com || self.fetch_from_bitcoin_average || self.fetch_from_coindesk
  end

  def self.fetch_from_bitcoin_com
    logger.info "Fetching btc price from bitcoin.com..."
    r = Net::HTTP.get(URI.parse('https://index.bitcoin.com/api/v0/price'))
    JSON.parse(r)['price']/100.0 rescue nil
  end

  def self.fetch_from_bitcoin_average
    logger.info "Fetching btc price from bitcoin average..."
    r = Net::HTTP.get(URI.parse('https://apiv2.bitcoinaverage.com/frontend/constants/exchangerates/global'))
    1.0/Float(JSON.parse(r)['rates']['BTC']['rate']) rescue nil
  end

  def self.fetch_from_coindesk
    logger.info "Fetching btc price from coindesk..."
    r = Net::HTTP.get(URI.parse('http://api.coindesk.com/v1/bpi/currentprice.json'))
    JSON.parse(r)['bpi']['USD']['rate_float'] rescue nil
  end

  def self.cache_key
    'btcusd'
  end

end
