class ChangeAcuerdosFechaToString < ActiveRecord::Migration
  def change
    change_column :acuerdos, :fecha, :string
  end
end
