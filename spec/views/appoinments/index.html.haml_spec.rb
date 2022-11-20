require "rails_helper"

RSpec.describe "appoinments/index" do
  let(:hospital) { create(:hospital, subdomain: "ursula") }
  let(:doctor) { create(:doctor, hospital_id: hospital.id) }
  let(:patient) { create(:patient, doctors: [doctor], hospital_id: hospital.id) }

  before do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    assign(:appoinments, Kaminari.paginate_array([
      @appoinment = Appoinment.create!(
        reason: "MyText",
        prescription: "MyText",
        cabinet_results: "MyText",
        histopathology: "MyText",
        doctor_id: doctor.id,
        patient_id: patient.id
      ),
      @appoinment_2 = Appoinment.create!(
        reason: "MyText",
        prescription: "MyText",
        cabinet_results: "MyText",
        histopathology: "MyText",
        doctor_id: doctor.id,
        patient_id: patient.id
      )
    ]).page(1))
  end

  it "renders a list of medical_consultations" do
    render
    assert_select "tr>td", text: @appoinment.id.to_s, count: 1
    assert_select "tr>td", text: @appoinment_2.id.to_s, count: 1

    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Marco Chavez Castro".to_s, count: 2
  end
end
