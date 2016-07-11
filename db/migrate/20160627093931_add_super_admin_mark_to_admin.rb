class AddSuperAdminMarkToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :is_superadmin, :boolean
  end
end
