# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'sidekiq'

Rails.application.load_tasks

namespace :sidekiq do
	desc "sidekiq daemon"
	task start: :environment do
		system "bundle exec sidekiq" +
			" -C ./config/sidekiq.yml" +
			" -d" +
			" -q usd_rate_#{Rails.env}_default" +
			" -q usd_rate_#{Rails.env}_broadcast"
	end
	desc "sidekiq in console with verbose logs"
	task verbose: :environment do
		system "bundle exec sidekiq" +
			" -C ./config/sidekiq.yml" +
			" -q usd_rate_#{Rails.env}_default" +
			" -q usd_rate_#{Rails.env}_broadcast" +
			" -v"
	end
end
