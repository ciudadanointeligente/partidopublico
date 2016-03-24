# == Schema Information
#
# Table name: acuerdos
#
#  id                     :integer          not null, primary key
#  numero                 :string
#  fecha                  :date
#  tipo                   :string
#  tema                   :string
#  region                 :string
#  organo_interno_id      :integer
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Acuerdo < ActiveRecord::Base
    has_attached_file :documento, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment :documento, 
        content_type: { content_type: "application/pdf" },
        size: { in: 0..5000.kilobytes }
  
    belongs_to :organo_interno
end
