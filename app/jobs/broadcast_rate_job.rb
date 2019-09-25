class BroadcastRateJob < ApplicationJob
  queue_as :broadcast

  def perform(*args)
    Sidekiq.logger.debug "BroadcastRateJob.perform"
    PushRateChannel.broadcast Rate.get_the_rate
  end
end
