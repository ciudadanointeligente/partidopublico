class AddOrdinalToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :ordinal, :string
  end
end
