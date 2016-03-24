# == Schema Information
#
# Table name: sedes
#
#  id         :integer          not null, primary key
#  region     :string
#  direccion  :string
#  contacto   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sede < ActiveRecord::Base
end
