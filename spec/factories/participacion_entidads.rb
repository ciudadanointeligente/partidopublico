# == Schema Information
#
# Table name: participacion_entidads
#
#  id                     :integer          not null, primary key
#  entidad                :string
#  descripcion            :string
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  partido_id             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  tipo_vinculo           :string
#  fecha_inicio           :string
#  fecha_fin              :string
#  rut                    :string
#  indefinido             :string
#  link                   :string
#
# Indexes
#
#  index_participacion_entidads_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :participacion_entidad do
    entidad "Nombre Entidad"
    descripcion "Descripcion entidad"
    tipo_vinculo ""
    fecha_inicio ""
    fecha_fin ""
  end
end
