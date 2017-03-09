class AllowPartidosSiglaToBeNull < ActiveRecord::Migration
  def change
    change_column :partidos, :sigla, :string, :null => true
  end
end
