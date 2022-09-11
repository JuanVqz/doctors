class CreatePatientReferrals < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_referrals do |t|
      t.string :subject
      t.text :content
      t.integer :importance, default: 0, null: false
      t.references :patient, null: false, foreign_key: {to_table: :users}
      t.references :doctor, null: false, foreign_key: {to_table: :users}
      t.references :referred_doctor, null: false, foreign_key: true
      t.references :hospital, null: false, foreign_key: true

      t.timestamps
    end
  end
end
