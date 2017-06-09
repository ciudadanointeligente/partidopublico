class AddLinkResolucionToSancion < ActiveRecord::Migration
  def change
    add_column :sancions, :link_resolucion, :string
  end
end
