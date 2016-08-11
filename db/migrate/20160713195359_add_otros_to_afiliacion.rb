class AddOtrosToAfiliacion < ActiveRecord::Migration
  def change
     add_column :afiliacions, :otros, :integer
  end
end
