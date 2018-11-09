class CreateMedicalConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_consultations do |t|
      t.text :reason
      t.text :subjetive
      t.text :objetive
      t.text :plan
      t.text :diagnosis
      t.text :treatment
      t.text :observations
      t.text :prescription
      t.text :lab_results
      t.text :histopathology
      t.text :comments
      t.references :doctor, foreign_key: { to_table: :users }
      t.references :patient, foreign_key: { to_table: :users }
      t.references :hospital, foreign_key: true

      t.timestamps
    end
  end
end
