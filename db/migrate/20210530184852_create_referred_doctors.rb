class CreateReferredDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :referred_doctors do |t|
      t.string :full_name
      t.string :specialty
      t.references :doctor, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
