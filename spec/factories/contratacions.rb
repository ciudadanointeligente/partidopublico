# == Schema Information
#
# Table name: contratacions
#
#  id                :integer          not null, primary key
#  partido_id        :integer
#  fecha_datos       :date
#  numero            :string
#  individualizacion :string
#  razon_social      :string
#  rut               :string
#  titulares         :string
#  descripcion       :string
#  monto             :integer
#  fecha_inicio      :date
#  fecha_termino     :date
#  link              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_contratacions_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :contratacion do
    partido nil
    fecha_datos "2016-08-09"
    numero "MyString"
    individualizacion "MyString"
    razon_social "MyString"
    rut "MyString"
    titulares "MyString"
    descripcion "MyString"
    monto 1
    fecha_inicio "2016-08-09"
    fecha_termino "2016-08-09"
    link "MyString"
  end
end
