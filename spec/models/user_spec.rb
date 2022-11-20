require "rails_helper"

RSpec.describe User do
  it { should validate_presence_of :role }
end
