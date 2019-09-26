class PushRateChannel < ApplicationCable::Channel

  def self.broadcast rate
    ActionCable.server.broadcast :push_rate_channel, format_msg(rate)
  end

  def subscribed
    stream_from :push_rate_channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  	def self.format_msg rate
  	  {
  	    rate:      rate.rate,
  	    overwrite: rate.overwrite,
  	  }
  	end

end
