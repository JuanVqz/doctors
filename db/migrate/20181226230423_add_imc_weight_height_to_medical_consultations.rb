# frozen_string_literal: true

class AddImcWeightHeightToMedicalConsultations < ActiveRecord::Migration[5.2]
  def change
    add_column :medical_consultations, :imc, :decimal, default: 0
    add_column :medical_consultations, :weight, :decimal, default: 0
    add_column :medical_consultations, :height, :decimal, default: 0
  end
end
