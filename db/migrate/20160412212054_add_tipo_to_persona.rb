class AddTipoToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :tipo, :string
  end
end
