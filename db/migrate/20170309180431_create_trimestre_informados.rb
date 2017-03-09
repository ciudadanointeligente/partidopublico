class CreateTrimestreInformados < ActiveRecord::Migration
  def change
    create_table :trimestre_informados do |t|
      t.integer :ano
      t.string :trimestre

      t.timestamps null: false
    end
  end
end
