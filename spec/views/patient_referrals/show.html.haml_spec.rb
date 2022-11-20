require "rails_helper"

RSpec.describe "patient_referrals/show" do
  let(:hospital) { create(:hospital) }
  let(:doctor) { create(:doctor, hospital: hospital) }
  let(:patient) { create(:patient, doctors: [doctor]) }
  let(:referred_doctor) { create(:referred_doctor, doctor: doctor) }

  before do
    @patient_referral = assign(:patient_referral, PatientReferral.create!(
      subject: "Subject",
      content: "MyText",
      patient: patient,
      doctor: doctor,
      referred_doctor: referred_doctor,
      hospital: hospital
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Paciente/)
    expect(rendered).to match(/Remitente/)
    expect(rendered).to match(/Destinatario/)
  end
end
