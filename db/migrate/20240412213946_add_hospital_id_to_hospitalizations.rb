class AddHospitalIdToHospitalizations < ActiveRecord::Migration[7.1]
  def change
    add_reference :hospitalizations, :hospital, foreign_key: true
  end
end
