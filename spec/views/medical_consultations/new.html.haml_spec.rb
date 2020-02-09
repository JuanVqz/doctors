require 'rails_helper'

RSpec.describe "medical_consultations/new", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    assign(:medical_consultation, MedicalConsultation.new(
      reason: "MyText",
      subjetive: "MyText",
      objetive: "MyText",
      plan: "MyText",
      diagnosis: "MyText",
      treatment: "MyText",
      observations: "MyText",
      prescription: "MyText",
      lab_results: "MyText",
      histopathology: "MyText",
      comments: "MyText",
      doctor_id: doctor.id,
      patient_id: patient.id,
      imc: "0.0",
      weight: "0.0",
      height: "0.0",
      blood_pressure: 0,
      heart_rate: 0,
      breathing_rate: 0,
      temperature: 0,
      glycaemia: 0,
      sat_02: 0,
      cost: 0,
      recommendation: ""
    ))
  end

  it "renders new medical_consultation form" do
    render

    assert_select "form[action=?][method=?]", medical_consultations_path, "post" do
      assert_select "textarea[name=?]", "medical_consultation[reason]"
      assert_select "textarea[name=?]", "medical_consultation[subjetive]"
      assert_select "textarea[name=?]", "medical_consultation[objetive]"
      assert_select "textarea[name=?]", "medical_consultation[plan]"
      assert_select "textarea[name=?]", "medical_consultation[diagnosis]"
      assert_select "textarea[name=?]", "medical_consultation[treatment]"
      assert_select "textarea[name=?]", "medical_consultation[observations]"
      assert_select "textarea[name=?]", "medical_consultation[prescription]"
      assert_select "textarea[name=?]", "medical_consultation[lab_results]"
      assert_select "textarea[name=?]", "medical_consultation[histopathology]"
      assert_select "textarea[name=?]", "medical_consultation[comments]"
      assert_select "select[name=?]", "medical_consultation[patient_id]"
      assert_select "input[name=?]", "medical_consultation[weight]"
      assert_select "input[name=?]", "medical_consultation[height]"
      assert_select "input[name=?]", "medical_consultation[blood_pressure]"
      assert_select "input[name=?]", "medical_consultation[heart_rate]"
      assert_select "input[name=?]", "medical_consultation[breathing_rate]"
      assert_select "input[name=?]", "medical_consultation[temperature]"
      assert_select "input[name=?]", "medical_consultation[glycaemia]"
      assert_select "input[name=?]", "medical_consultation[sat_02]"
      assert_select "input[name=?]", "medical_consultation[cost]"
      assert_select "textarea[name=?]", "medical_consultation[recommendation]"
    end
  end
end
