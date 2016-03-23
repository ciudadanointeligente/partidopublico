class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :genero
      t.date :fecha_nacimiento
      t.string :nivel_estudios
      t.string :region
      t.integer :ano_inicio_militancia
      t.boolean :afiliado
      t.text :bio

      t.timestamps null: false
    end
  end
end
