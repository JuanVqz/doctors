class CreateHospitalizations < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitalizations do |t|
      t.date :starting
      t.date :ending
      t.decimal :days_of_stay
      t.text :reason_for_hospitalization
      t.text :treatment
      t.references :doctor, foreign_key: { to_table: :users }
      t.references :patient, foreign_key: { to_table: :users }
      t.references :hospital, foreign_key: true

      t.timestamps
    end
  end
end
