class AddReferredDoctorToHospitalization < ActiveRecord::Migration[6.1]
  def change
    add_reference :hospitalizations, :referred_doctor, foreign_key: true
  end
end
