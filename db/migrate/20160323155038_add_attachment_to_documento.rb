class AddAttachmentToDocumento < ActiveRecord::Migration
  def self.up
    change_table :documentos do |t|
      t.attachment :archivo
    end
  end

  def self.down
    remove_attachment :documentos, :archivo
  end
end
