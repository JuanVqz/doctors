require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should belong_to :addressable }

  it { should validate_presence_of :street }
  it { should validate_presence_of :colony }
  it { should validate_presence_of :postal_code }
  it { should validate_presence_of :municipality }
  it { should validate_presence_of :state }
  it { should validate_presence_of :country }
end
