# frozen_string_literal: true

class AddStatusToHospitalizations < ActiveRecord::Migration[6.1]
  def change
    add_column :hospitalizations, :status, :integer, default: 0
  end
end
