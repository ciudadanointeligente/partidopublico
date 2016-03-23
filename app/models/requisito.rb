class Requisito < ActiveRecord::Base
    belongs_to :requisitable, polymorphic: true
end
