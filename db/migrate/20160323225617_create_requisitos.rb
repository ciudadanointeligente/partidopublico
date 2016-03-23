class CreateRequisitos < ActiveRecord::Migration
  def change
    create_table :requisitos do |t|
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
