class Rate < ApplicationRecord

	# virtual values for controlelrs and views
	attr_accessor :mantissa, :fraction, :overwrite, :skip_overwrite_validation

	# validations
	validates :mantissa, presence: true
	validates :mantissa, numericality: {
		only_integer:             true,
		greater_than_or_equal_to: 0,
		less_than_or_equal_to:    5000
	}

	validates :fraction, presence: true
	validates :fraction, numericality: {
		only_integer:             true,
		greater_than_or_equal_to: 0,
		less_than_or_equal_to:    9999
	}

	validate :rate_should_not_be_zero

	validates :overwrite, presence: true, unless: :skip_overwrite_validation

	def rate_should_not_be_zero
		if zero? then
			errors.add(:rate, :cant_be_zero)
		end
	end

	#
	# initializers
	#

	after_initialize do |rate|
		# doesn't need
		#
		# rate.mantissa = 0
		# rate.fraction = 0
		if rate.overwrite == nil then
			rate.overwrite = Time.now
		end
	end

	after_find do |rate|
		# set @mantissa and @fraction to fetched or overwritten,
		# depending the overwrite_until
		rate.overwrite = rate.overwrite_until
		if rate.overwritten? then
			rate.mantissa = mantissa_overwrite
			rate.fraction = fraction_overwrite
		else
			rate.mantissa = mantissa_fetched
			rate.fraction = fraction_fetched
		end
	end

	#
	# db columns
	#

    # mantissa_fetched } of the rate fetched from the cbr
    # fraction_fetched }

    # mantissa_overwrite } overwritten by an admin
    # fraction_overwrite }

    # overwrite_until    } the rate is overwritten until this time

    # get rate from db regards the overwritting
	def self.get_the_rate
		first or Rate.new
	end

	def rate
		return @mantissa.to_f + (@fraction.to_f / 10_000)
	end

	# overwrite/reset the overwritting depending on timestamp
	def overwrite_the_rate params
		logger.info "overwrite_the_rate: #{params}"
		rate = params[:rate].to_f
		@mantissa = rate.to_i
		@fraction = ((rate - @mantissa)*10_000).round
		@overwrite = params[:overwrite]
		if not valid? then
			logger.info "overwrite_the_rate: invalid params: #{errors.full_messages}"
			return false
		end
		was_overwritten = overwritten?
		self.mantissa_overwrite = @mantissa
		self.fraction_overwrite = @fraction
		self.overwrite_until = @overwrite
		# already validated
		if save(validate: false) then
			if overwritten? then
				if was_overwritten then
					ApplicationJob.clear :broadcast
				end
				BroadcastRateJob.set(wait_until: overwrite_until).perform_later
			else
				@mantissa = self.mantissa_fetched
				@fraction = self.fraction_fetched
				if was_overwritten then
					ApplicationJob.clear :broadcast # becomes not overwritten
				end
			end
			BroadcastRateJob.perform_later # broadcas new rate
			return true # saved succesfully
		else
			return false # saving error
		end
	end

	# update by fetched, this method called in FetchRateJob
	def self.update_the_rate mantissa, fraction
		logger.debug "update the rate #{mantissa}.#{fraction}"
		rate = get_the_rate
		rate.mantissa = mantissa
		rate.fraction = fraction
		skip_overwrite_validation = true
		if not rate.valid? then
			logger.error "invaid values fetched from cbr: #{mantissa}.#{fraction}"
			return
		end
		rate.mantissa_fetched = mantissa
		rate.fraction_fetched = fraction
		if not rate.save validate: false then # already validated
			return false # saving error
		end
		BroadcastRateJob.perform_later
		true
	end

	# rate is zero (not fetched nor set yet)
	def zero?
		@mantissa.to_i == 0 && @fraction.to_i == 0
	end

	# rate is overwritten currenly
	def overwritten?
		@overwrite > Time.now rescue false
	end

end
