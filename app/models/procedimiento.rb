class Procedimiento < ActiveRecord::Base
    belongs_to :procedimentable, polymorphic: true
end
