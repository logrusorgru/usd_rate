class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.integer   :mantissa   # fetched mantissa
      t.integer   :fraction   # fetched fraction
      t.timestamp :set_until # rate is set until this time
    end
  end
end
