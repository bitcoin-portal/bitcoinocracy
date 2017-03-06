module ApplicationHelper
	def btc_human(satoshies, options = {prefix: '', suffix: '&nbsp;BTC'} )
    "#{options[:prefix]}%.8f#{options[:suffix]}".html_safe % (1.0*satoshies.to_i/1e8)
	end

	def btc_human_spaced(satoshies, options = {prefix: '', suffix: ' BTC'} )
		number_to_currency(1.0*satoshies.to_i/1e8, unit: options[:suffix], precision: 8, delimiter: " ", format: "%n %u").html_safe
	end

  def percent_human(x)
    if x.present?
      "(%.2f%%)" % (100.0*x)
    else
      ""
    end
  end
end
