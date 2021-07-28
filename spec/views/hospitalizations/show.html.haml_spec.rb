require 'rails_helper'

RSpec.describe "hospitalizations/show", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    @hospitalization = assign(:hospitalization, Hospitalization.create!(
      starting: "2018-11-10",
      ending: "2018-11-12",
      days_of_stay: "2.0",
      reason_for_hospitalization: "Razon",
      treatment: "Tratamiento",
      doctor_id: doctor.id,
      patient_id: patient.id,
      recommendations: "Recomendaciones",
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Razon/)
    expect(rendered).to match(/Tratamiento/)
    expect(rendered).to match(/Recomendaciones/)
  end
end
