# frozen_string_literal: true

class AddAttributesToHospitalization < ActiveRecord::Migration[6.1]
  def change
    add_column :hospitalizations, :input_diagnosis, :text
    add_column :hospitalizations, :output_diagnosis, :text
    add_column :hospitalizations, :recommendations, :text
  end
end
