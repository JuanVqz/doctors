require "rails_helper"

RSpec.describe Address do
  it { should belong_to :addressable }

  it { should validate_presence_of :state }
end
