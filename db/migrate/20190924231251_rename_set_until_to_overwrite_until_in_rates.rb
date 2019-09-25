class RenameSetUntilToOverwriteUntilInRates < ActiveRecord::Migration[5.2]
  def change
    change_table :rates do |t|
      t.rename :set_until, :overwrite_until
    end
  end
end
