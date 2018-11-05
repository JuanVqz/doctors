class CreateJoinTableDoctorsPatients < ActiveRecord::Migration[5.2]
  def change
    create_join_table :doctors, :patients do |t|
      t.index [:doctor_id, :patient_id]
      t.index [:patient_id, :doctor_id]
    end
  end
end
