require 'rails_helper'

RSpec.describe Hospital, type: :model do
  it { should validate_uniqueness_of :subdomain }
end
