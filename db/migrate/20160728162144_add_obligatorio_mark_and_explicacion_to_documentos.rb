class AddObligatorioMarkAndExplicacionToDocumentos < ActiveRecord::Migration
  def change
    add_column :documentos, :obligatorio, :boolean
    add_column :documentos, :explicacion, :string
  end
end
