class AddLinkInformacionToTramite < ActiveRecord::Migration
  def change
    add_column :tramites, :link_informacion, :string
  end
end
