class AddProcedimentableToProcedimiento < ActiveRecord::Migration
  def change
    add_reference :procedimientos, :procedimentable, polymorphic: true, index: {:name => "index_procedimentable_type_and_id"}
  end
end
