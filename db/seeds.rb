# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create first record
if Rate.all.empty? then
	rate = Rate.new
	rate.mantissa_fetched   = 0,
	rate.fraction_fetched   = 0,
	rate.mantissa_overwrite = 0,
	rate.fraction_overwrite = 0,
	rate.overwrite_until    = Time.now
	rate.save validate: false
end
