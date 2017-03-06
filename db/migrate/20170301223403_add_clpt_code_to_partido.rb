class AddClptCodeToPartido < ActiveRecord::Migration
  def change
    add_column :partidos, :cplt_code, :string, index: true
  end
end
