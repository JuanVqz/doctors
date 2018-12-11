class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals do |t|
      t.string :name, unique: true
      t.string :subdomain, unique: true
      t.string :description
      t.integer :plan, default: 0, null: false

      t.timestamps
    end
  end
end
