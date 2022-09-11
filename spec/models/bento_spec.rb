require "rails_helper"

RSpec.describe Bento, type: :model do
  it { should belong_to :patient }
  it { should validate_presence_of :code }
  it { should validate_presence_of :patient }
  it { should validate_uniqueness_of :code }
end
