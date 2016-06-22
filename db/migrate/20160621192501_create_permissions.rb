class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :admin, index: true, foreign_key: true
      t.references :partido, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
