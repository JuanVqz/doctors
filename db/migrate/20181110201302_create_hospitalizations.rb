class CreateHospitalizations < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitalizations do |t|
      t.date :starting
      t.date :ending
      t.decimal :days_of_stay
      t.text :reason_for_hospitalization, default: ""
      t.text :treatment, default: ""
      t.references :doctor, foreign_key: {to_table: :users}
      t.references :patient, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
