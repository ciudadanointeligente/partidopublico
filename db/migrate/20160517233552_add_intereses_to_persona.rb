class AddInteresesToPersona < ActiveRecord::Migration
  def change
     add_column :personas, :intereses, :string
  end
end
