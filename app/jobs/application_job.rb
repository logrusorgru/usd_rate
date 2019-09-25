class ApplicationJob < ActiveJob::Base

	# clear queue including scheduled jobs
	def self.clear name
		queue(name).clear
		scheduled.each do |job|
			job.delete if job.queue == queue_name(name)
		end
	end

	def self.queue name
		Sidekiq::Queue.new(queue_name name)
	end

	def self.scheduled
		Sidekiq::ScheduledSet.new
	end

	def self.queue_name name
		"#{Rails.configuration.active_job.queue_name_prefix}_#{name}"
	end
end
