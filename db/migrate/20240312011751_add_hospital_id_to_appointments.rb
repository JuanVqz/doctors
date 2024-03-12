class AddHospitalIdToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_reference :appointments, :hospital, foreign_key: true
  end
end
