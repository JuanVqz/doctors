require "rails_helper"

RSpec.describe "appoinments/show", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    @appoinment = assign(:appoinment, Appoinment.create!(
      reason: "MyText",
      prescription: "MyText",
      cabinet_results: "MyText",
      histopathology: "MyText",
      doctor_id: doctor.id,
      patient_id: patient.id
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
