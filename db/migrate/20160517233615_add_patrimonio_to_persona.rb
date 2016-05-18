class AddPatrimonioToPersona < ActiveRecord::Migration
  def change
    
     add_column :personas, :patrimonio, :string
  end
end
