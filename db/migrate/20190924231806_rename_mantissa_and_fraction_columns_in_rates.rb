class RenameMantissaAndFractionColumnsInRates < ActiveRecord::Migration[5.2]
  def change
    change_table :rates do |t|
      t.rename :mantissa, :mantissa_fetched
      t.rename :fraction, :fraction_fetched
    end
  end
end
