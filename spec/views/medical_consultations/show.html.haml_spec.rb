require 'rails_helper'

RSpec.describe "medical_consultations/show", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    @medical_consultation = assign(:medical_consultation, MedicalConsultation.create!(
      :reason => "MyText",
      :subjetive => "MyText",
      :objetive => "MyText",
      :plan => "MyText",
      :diagnosis => "MyText",
      :treatment => "MyText",
      :observations => "MyText",
      :prescription => "MyText",
      :lab_results => "MyText",
      :histopathology => "MyText",
      :comments => "MyText",
      :doctor_id => doctor.id,
      :patient_id => patient.id
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
