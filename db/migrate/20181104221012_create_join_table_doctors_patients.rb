# frozen_string_literal: true

class CreateJoinTableDoctorsPatients < ActiveRecord::Migration[5.2]
  def change
    create_join_table :doctors, :patients do |t|
      t.index %i[doctor_id patient_id]
      t.index %i[patient_id doctor_id]
    end
  end
end
