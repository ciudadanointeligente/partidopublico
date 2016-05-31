class CreateSancions < ActiveRecord::Migration
  def change
    create_table :sancions do |t|
      t.string :descripcion
      t.string :institucion
      t.date :fecha
      t.attachment :documento

      t.timestamps null: false
    end
  end
end
