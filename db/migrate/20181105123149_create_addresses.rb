# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :colony
      t.string :postal_code
      t.string :municipality
      t.string :state, default: 'Oaxaca'
      t.string :country, default: 'México'
      t.references :addressable, polymorphic: true

      t.timestamps
    end
  end
end
