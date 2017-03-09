class AllowPartidosLemaToBeNull < ActiveRecord::Migration
  def change
    change_column :partidos, :lema, :string, :null => true
  end
end
