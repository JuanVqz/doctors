class DropMedicalConsultations < ActiveRecord::Migration[7.1]
  def change
    drop_table :medical_consultations do |t|
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
      t.references :doctor, foreign_key: {to_table: :users}
      t.references :patient, foreign_key: {to_table: :users}
      t.timestamps
      t.float :imc, default: 0
      t.float :weight, default: 0
      t.float :height, default: 0
      t.string :blood_pressure, default: ""
      t.float :heart_rate, default: 0
      t.float :breathing_rate, default: 0
      t.float :temperature, default: 0
      t.float :glycaemia, default: 0
      t.float :sat_02, default: 0
      t.float :cost, default: 0
      t.text :recommendation, default: ""
    end
  end
end
