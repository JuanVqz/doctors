# frozen_string_literal: true

class CreateBentos < ActiveRecord::Migration[5.2]
  def change
    create_table :bentos do |t|
      t.string :code
      t.references :patient, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
