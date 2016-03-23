class AddPersonableToPersona < ActiveRecord::Migration
  def change
    add_reference :personas, :personable, polymorphic: true, index: true
  end
end
