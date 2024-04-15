# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HospitalsController do
  describe 'routing' do
    it 'routes to #edit' do
      expect(get: '/hospitals/1/edit').to route_to('hospitals#edit', id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/hospitals/1').to route_to('hospitals#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/hospitals/1').to route_to('hospitals#update', id: '1')
    end
  end
end
