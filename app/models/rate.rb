class Rate < ApplicationRecord

	# virtual values for controlelrs and views
	attr_accessor :mantissa, :fraction, :overwrite, :skip_overwrite_validation

	# validations
	validates :mantissa, presence: true
	validates :mantissa, numericality: {
		only_integer:          true,
		greater_than:          0,
		less_than_or_equal_to: 5000
	}

	validates :fraction, presence: true
	validates :fraction, numericality: {
		only_integer:          true,
		greater_than:          0,
		less_than_or_equal_to: 9999
	}

	validate :rate_should_not_be_zero

	validates :overwrite, presence: true, unless: :skip_overwrite_validation

	def rate_should_not_be_zero
		if mantissa == 0 && fraction == 0 then
			errors.add(:rate_is_zero, "rate can't be zero")
		end
	end

	#
	# initializers
	#

	after_initialize do |rate|
		mantissa = 0
		fraction = 0
		overwrite = Time.now
	end

	after_find do |rate|
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

	# overwrite/reset the overwritting depending on timestamp
	def self.overwrite_the_rate params
		mantissa = params[:mantissa]
		fraction = params[:fraction]
		overwrite = params[:overwrite]
		if not valid? then
			return false
		end
		was_overwritten = overwritten?
		mantissa_overwrite = mantissa
		fraction_overwrite = fraction
		overwrite_until = overwrite
		if save(validate: false) then
			if overwritten? then
				if was_overwritten then
					# todo: stop existing waiting job
				end
				# todo: start job waiting for overwrite timeout
			elsif was_overwritten then
				# becomes not overwritten
				# todo: stop existing waiting job
			end
			# todo: start job 'push new rate to clients'
			return true # saved succesfully
		else
			return false # saving error
		end
	end

	# update by fetched
	def self.update_the_rate mantissa, fraction
		rate.mantissa = mantissa
		rate.fraction = fraction
		skip_overwrite_validation = true
		if rate.valid? then
			logger.error "invaid values fetched from cbr: #{mantissa}.#{fraction}"
			return
		end
		rate.mantissa_fetched = mantissa
		rate.fraction_fetched = fraction
		rate.save validate: false # already validated
	end

	# rate is zero (not fetched nor set yet)
	def zero?
		mantissa == 0 && fraction == 0
	end

	# rate is overwritten currenly
	def overwritten?
		overwrite < Time.now rescue false
	end

end
