class AlterFechaToDateTimeAtAdminLogin < ActiveRecord::Migration
  def change
    change_column :admin_logins, :fecha, :datetime
  end
end
