class FetchRateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Sidekiq.logger.debug "FetchRateJob.perform"
    fr = get_usd_exchange_rate.to_f
    if fr == 0.0 then
      Sidekiq.logger.error "FetchRateJob.perform: zero rate fetched"
      return
    end
    Rate.update_the_rate fr.floor, ((fr - fr.floor)*10000).to_i
  end

  protected

    # get the rate by cbr api
    def get_usd_exchange_rate
      Sidekiq.logger.debug "get_usd_exchange_rate"
      begin
        today = Time.now.strftime '%d/%m/%Y'
        uri = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=#{today}"
        doc = Nokogiri::XML(open(uri))
        text = doc.xpath('//ValCurs/Valute[@ID="R01235"]/Value').text
        return text.gsub(',', '.')
      rescue Exception => excp
        Sidekiq.logger.error "rate loading error: #{excp}"
        return ""
      end
    end

end
