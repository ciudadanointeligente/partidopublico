class AddUserToPartidos < ActiveRecord::Migration
  def change
    add_reference :partidos, :user, index: true, foreign_key: true
  end
end
