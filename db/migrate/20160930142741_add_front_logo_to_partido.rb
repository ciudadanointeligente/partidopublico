class AddFrontLogoToPartido < ActiveRecord::Migration
  def change
    change_table :partidos do |t|
      t.attachment :front_logo
    end
  end
end
