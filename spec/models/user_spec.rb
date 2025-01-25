# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { should belong_to :hospital }

  it { should define_enum_for(:role).with_values(%i[patient doctor admin]) }

  it { should validate_presence_of :role }
  it { should validate_presence_of :hospital }
end
