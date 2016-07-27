class CreateAdminLogins < ActiveRecord::Migration
  def change
    create_table :admin_logins do |t|
      t.date :fecha
      t.string :ip
      t.references :admin, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
