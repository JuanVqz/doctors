# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  it 'sexos_for_select' do
    expect(helper.sexos_for_select).to eq(%w[Femenino Masculino])
  end

  it 'blood_groups_for_select' do
    groups = ['ARH+', 'ORH+', 'BRH+', 'ABRH+', 'ARH-', 'ORH-', 'BRH-', 'ABRH-']
    expect(helper.blood_groups_for_select).to eq groups
  end

  context '#sidebar_classes' do
    it 'returns hover classes' do
      allow(helper).to receive(:controller_name).and_return(:controller_name)
      expect(helper.sidebar_classes(:controller_name)).to eq 'flex p-2 rounded-lg hover:bg-gray-200 dark:hover:bg-gray-700 bg-gray-200 dark:bg-gray-700'
    end

    it 'does not return hover classes' do
      allow(helper).to receive(:controller_name).and_return(:controller_name)
      expect(helper.sidebar_classes(:foo)).to eq 'flex p-2 rounded-lg hover:bg-gray-200 dark:hover:bg-gray-700'
    end
  end

  it '#height_for_human' do
    object = double('object', height: 180)
    expect(helper.height_for_human(object)).to eq '180 cm'
  end

  it '#weight_for_human' do
    object = double('object', weight: 80)
    expect(helper.weight_for_human(object)).to eq '80 kg'
  end

  context '#imc_for_human' do
    it 'returns 22.22' do
      object = double('object', height: 150, weight: 50)
      expect(helper.imc_for_human(object)).to eq 22.22
    end

    it 'returns N/A' do
      object = double('object', height: nil, weight: nil)
      expect(helper.imc_for_human(object)).to eq 'N/A'
    end

    it 'returns N/A' do
      object = double('object', height: 0, weight: 0)
      expect(helper.imc_for_human(object)).to eq 'N/A'
    end
  end
end
