class CreateClinicHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :clinic_histories do |t|
      t.text :description_diabetes
      t.text :description_hypertension
      t.text :description_allergic
      t.text :description_traumatic
      t.text :description_transfusion
      t.text :description_surgical
      t.text :description_drug_addiction
      t.text :description_hereditary
      t.text :description_cancer
      t.text :description_other
      t.references :patient, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
