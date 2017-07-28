class AddFieldsToEntidads < ActiveRecord::Migration
  def change
    add_column :participacion_entidads, :rut, :string
    add_column :participacion_entidads, :indefinido, :string
    add_column :participacion_entidads, :link, :string
  end
end
