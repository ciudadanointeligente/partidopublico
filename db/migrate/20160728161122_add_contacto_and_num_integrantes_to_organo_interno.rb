class AddContactoAndNumIntegrantesToOrganoInterno < ActiveRecord::Migration
  def change
    add_column :organo_internos, :contacto, :string
    add_column :organo_internos, :num_integrantes, :integer
  end
end
