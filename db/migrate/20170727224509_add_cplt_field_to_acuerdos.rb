class AddCpltFieldToAcuerdos < ActiveRecord::Migration
  def change
    add_column :acuerdos, :materia, :string
    add_column :acuerdos, :nombre_organo, :string
    add_column :acuerdos, :denominacion, :string
    add_column :acuerdos, :descripcion, :string
    add_column :acuerdos, :link, :string
  end
end
