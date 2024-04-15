# frozen_string_literal: true

class AddUnaccentExtension < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'unaccent'
  end
end
