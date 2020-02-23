require 'rails_helper'

RSpec.describe "appoinments/new", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    assign(:appoinment, Appoinment.new(
      reason: "MyText",
      note: "MyText",
      prescription: "MyText",
      cabinet_results: "MyText",
      histopathology: "MyText",
      doctor_id: doctor.id,
      patient_id: patient.id,
      recommendations: "MyText",
      imc: "0.0",
      weight: "0.0",
      height: "0.0",
      blood_pressure: 0,
      heart_rate: 0,
      breathing_rate: 0,
      temperature: 0,
      glycaemia: 0,
      sat_02: 0,
      cost: 0
    ))
  end

  it "renders new appoinment form" do
    render

    assert_select "form[action=?][method=?]", appoinments_path, "post" do
      assert_select "select[name=?]", "appoinment[patient_id]"
      assert_select "input[name=?]", "appoinment[reason]"

      assert_select "input[name=?]", "appoinment[imc]"
      assert_select "input[name=?]", "appoinment[weight]"
      assert_select "input[name=?]", "appoinment[height]"

      assert_select "input[name=?]", "appoinment[blood_pressure]"
      assert_select "input[name=?]", "appoinment[heart_rate]"
      assert_select "input[name=?]", "appoinment[breathing_rate]"
      assert_select "input[name=?]", "appoinment[temperature]"
      assert_select "input[name=?]", "appoinment[glycaemia]"
      assert_select "input[name=?]", "appoinment[sat_02]"

      assert_select "textarea[name=?]", "appoinment[cabinet_results]"
      assert_select "textarea[name=?]", "appoinment[histopathology]"

      assert_select "input[name=?]", "appoinment[cost]"
    end
  end
end
