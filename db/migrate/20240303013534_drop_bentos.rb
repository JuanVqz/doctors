class DropBentos < ActiveRecord::Migration[7.1]
  def change
    drop_table :bentos do |t|
      t.string :code
      t.references :patient, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
