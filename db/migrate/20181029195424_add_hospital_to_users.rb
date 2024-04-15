# frozen_string_literal: true

class AddHospitalToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hospital_id, :integer
    add_index :users, :hospital_id
  end
end
