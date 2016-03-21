class AddAttachmentLogoToPartidos < ActiveRecord::Migration
  def self.up
    change_table :partidos do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :partidos, :logo
  end
end
