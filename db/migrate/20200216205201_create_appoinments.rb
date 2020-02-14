class CreateAppoinments < ActiveRecord::Migration[5.2]
  def change
    create_table :appoinments do |t|
      t.string :reason
      t.text :note
      t.text :prescription
      t.text :recomendations
      t.references :doctor, foreign_key: { to_table: :users }
      t.references :patient, foreign_key: { to_table: :users }
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
      t.text :cabinet_results
      t.text :histopathology

      t.timestamps
    end
  end
end
