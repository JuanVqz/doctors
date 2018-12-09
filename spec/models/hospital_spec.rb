require 'rails_helper'

RSpec.describe Hospital, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :subdomain }
  it { should validate_uniqueness_of :subdomain }
end
