class AddRequerimentableToRequerimiento < ActiveRecord::Migration
  def change
    add_reference :requisitos, :requisitable, polymorphic: true, index: {:name => "index_requisitable_type_and_id"}
  end
end
