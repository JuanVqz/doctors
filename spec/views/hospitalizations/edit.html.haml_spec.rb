require "rails_helper"

RSpec.describe "hospitalizations/edit" do
  let(:hospital) { create(:hospital, subdomain: "ursula") }
  let(:doctor) { create(:doctor, hospital_id: hospital.id) }

  let(:patient) { create(:patient, doctors: [doctor], hospital_id: hospital.id) }

  before do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    @hospitalization = assign(:hospitalization, Hospitalization.create!(
      starting: "2018-11-10",
      ending: "2018-11-12",
      days_of_stay: "2.0",
      reason_for_hospitalization: "Razon",
      treatment: "Tratamiento",
      doctor_id: doctor.id,
      patient_id: patient.id
    ))
  end

  it "renders the edit hospitalization form" do
    render

    assert_select "form[action=?][method=?]", hospitalization_path(@hospitalization), "post" do
      assert_select "select[name=?]", "hospitalization[patient_id]"
      assert_select "input[name=?]", "hospitalization[days_of_stay]"
      assert_select "trix-editor[input=?]", "hospitalization_input_diagnosis"
      assert_select "trix-editor[input=?]", "hospitalization_output_diagnosis"
      assert_select "trix-editor[input=?]", "hospitalization_reason_for_hospitalization"
      assert_select "trix-editor[input=?]", "hospitalization_treatment"
      assert_select "trix-editor[input=?]", "hospitalization_recommendations"
    end
  end
end
