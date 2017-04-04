class AddPersonaNaturalToTransferencias < ActiveRecord::Migration
  def change
    add_column :transferencias, :persona_natural, :string
  end
end
