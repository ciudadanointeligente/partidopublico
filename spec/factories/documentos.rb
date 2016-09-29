# == Schema Information
#
# Table name: documentos
#
#  id                   :integer          not null, primary key
#  descripcion          :string
#  documentable_id      :integer
#  documentable_type    :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  archivo_file_name    :string
#  archivo_content_type :string
#  archivo_file_size    :integer
#  archivo_updated_at   :datetime
#  obligatorio          :boolean
#  explicacion          :string
#
# Indexes
#
#  index_documentos_on_documentable_type_and_documentable_id  (documentable_type,documentable_id)
#

FactoryGirl.define do
  factory :documento do
    descripcion "MyString"
    archivo { File.new("#{Rails.root}/spec/fixtures/documents/document_test.pdf") } 
  end
end
