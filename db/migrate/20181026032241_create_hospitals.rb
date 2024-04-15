# frozen_string_literal: true

class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals do |t|
      t.string :name, unique: true
      t.string :subdomain, unique: true
      t.string :description
      t.integer :plan, default: 0, null: false
      t.text :about
      t.text :schedule
      t.string :tags
      t.string :facebook, default: 'https://www.facebook.com/'
      t.string :twitter, default: 'https://twitter.com/?lang=es'
      t.string :linkedin, default: 'https://www.linkedin.com/'
      t.string :maps, default: 'https://www.google.com/maps'

      t.timestamps
    end
  end
end
