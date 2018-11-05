require "rails_helper"

RSpec.describe Patient, type: :model do
  it { should have_and_belong_to_many :doctors }

  it { should validate_presence_of :name }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :birthday }
  it { should validate_presence_of :height }
  it { should validate_presence_of :weight }
end
