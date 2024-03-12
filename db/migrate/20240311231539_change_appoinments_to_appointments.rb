class ChangeAppoinmentsToAppointments < ActiveRecord::Migration[7.1]
  def change
    rename_table :appoinments, :appointments
  end
end
