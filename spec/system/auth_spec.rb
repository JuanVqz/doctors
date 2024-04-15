# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auth flow', type: :system do
  before do
    driven_by(:headless_firefox)
  end

  feature 'Auth' do
    scenario 'signs out' do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      expect(page).to have_content @admin.name
      find('a[data-turbo-method="delete"]').click

      expect(page).to have_content @hospital
      expect(page).to have_content 'Iniciar sesión'
    end
  end
end
