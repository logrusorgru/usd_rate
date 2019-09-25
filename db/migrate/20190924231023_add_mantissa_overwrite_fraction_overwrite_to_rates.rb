class AddMantissaOverwriteFractionOverwriteToRates < ActiveRecord::Migration[5.2]
  def change
    add_column :rates, :mantissa_overwrite, :integer
    add_column :rates, :fraction_overwrite, :integer
  end
end
