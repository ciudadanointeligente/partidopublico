class AddTipoCampanaToEgresoCampana < ActiveRecord::Migration
  def change
    add_column :egreso_campanas, :tipo_campana, :string
  end
end
