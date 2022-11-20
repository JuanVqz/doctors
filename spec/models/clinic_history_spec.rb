require "rails_helper"

RSpec.describe ClinicHistory do
  it { should belong_to :patient }
end
