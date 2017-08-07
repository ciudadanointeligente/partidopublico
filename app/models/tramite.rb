# == Schema Information
#
# Table name: tramites
#
#  id                     :integer          not null, primary key
#  nombre                 :string
#  descripcion            :string
#  persona_id             :integer
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  partido_id             :integer
#  procedimiento          :string
#  requisito              :string
#  link_informacion       :string
#
# Indexes
#
#  index_tramites_on_partido_id  (partido_id)
#  index_tramites_on_persona_id  (persona_id)
#

class Tramite < ActiveRecord::Base
    has_paper_trail
    has_attached_file :documento, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/resources/missing.png"
    validates_attachment :documento,
        content_type: { content_type: "application/pdf" },
        size: { in: 0..5000.kilobytes }

    belongs_to :partido
    belongs_to :persona
    has_many :requisitos, as: :requisitable
    has_many :procedimientos, as: :procedimentable
    has_and_belongs_to_many :trimestre_informados

    accepts_nested_attributes_for :persona, reject_if: proc { |attributes| attributes['nombre'].blank? }, allow_destroy: true
    accepts_nested_attributes_for :requisitos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
    accepts_nested_attributes_for :procedimientos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
end
