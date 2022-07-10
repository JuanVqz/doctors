require "rails_helper"

RSpec.describe "referred_doctors/show", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  before do
    @referred_doctor = assign(:referred_doctor, ReferredDoctor.create!(
      full_name: "Full Name",
      specialty: "Specialty",
      doctor: doctor
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Full Name/)
    expect(rendered).to match(/Specialty/)
  end
end
