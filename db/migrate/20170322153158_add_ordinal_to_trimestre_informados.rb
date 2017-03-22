class AddOrdinalToTrimestreInformados < ActiveRecord::Migration
  def change
    add_column :trimestre_informados, :ordinal, :integer
  end
end
