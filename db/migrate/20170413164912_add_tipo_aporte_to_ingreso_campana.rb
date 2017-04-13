class AddTipoAporteToIngresoCampana < ActiveRecord::Migration
  def change
    add_column :ingreso_campanas, :tipo_aporte, :string
  end
end
