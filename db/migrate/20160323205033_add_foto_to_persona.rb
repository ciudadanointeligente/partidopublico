class AddFotoToPersona < ActiveRecord::Migration
  def self.up
    change_table :personas do |t|
      t.attachment :foto
    end
  end

  def self.down
    remove_attachment :personas, :foto
  end
end
