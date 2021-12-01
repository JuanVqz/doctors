require "rails_helper"

RSpec.describe Address, type: :model do
  it { should belong_to :addressable }

  it { should validate_presence_of :state }
end
