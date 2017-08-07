class AddRequisitoToTramite < ActiveRecord::Migration
  def change
    add_column :tramites, :requisito, :string
  end
end
