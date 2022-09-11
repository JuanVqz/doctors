class AddVitalSignsToMedicalConsultations < ActiveRecord::Migration[5.2]
  def change
    add_column :medical_consultations, :blood_pressure, :string, default: ""
    add_column :medical_consultations, :heart_rate, :float, default: 0
    add_column :medical_consultations, :breathing_rate, :float, default: 0
    add_column :medical_consultations, :temperature, :float, default: 0
    add_column :medical_consultations, :glycaemia, :float, default: 0
    add_column :medical_consultations, :sat_02, :float, default: 0
    add_column :medical_consultations, :cost, :float, default: 0
    add_column :medical_consultations, :recommendation, :text, default: ""
  end
end
