# frozen_string_literal: true

class AddBackgroundHistoryToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :allergies, :text, default: ''
    add_column :users, :pathological_background, :text, default: ''
    add_column :users, :non_pathological_background, :text, default: ''
    add_column :users, :gyneco_obstetric_background, :text, default: ''
    add_column :users, :system_background, :text, default: ''
    add_column :users, :family_inheritance_background, :text, default: ''
    add_column :users, :physic_exploration, :text, default: ''
    add_column :users, :other_background, :text, default: ''
  end
end
