class AddUrlToPartido < ActiveRecord::Migration
  def change
    add_column :partidos, :url, :string
  end
end
