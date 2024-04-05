class AddHospitalIdToReferredDoctors < ActiveRecord::Migration[7.1]
  def change
    add_reference :referred_doctors, :hospital, foreign_key: true
  end
end
