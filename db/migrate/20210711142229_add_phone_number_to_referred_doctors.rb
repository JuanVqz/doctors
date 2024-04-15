# frozen_string_literal: true

class AddPhoneNumberToReferredDoctors < ActiveRecord::Migration[6.1]
  def change
    add_column :referred_doctors, :phone_number, :string
  end
end
