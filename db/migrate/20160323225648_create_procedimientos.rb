class CreateProcedimientos < ActiveRecord::Migration
  def change
    create_table :procedimientos do |t|
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
