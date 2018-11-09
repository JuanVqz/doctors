require 'rails_helper'

RSpec.describe "medical_consultations/new", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    assign(:medical_consultation, MedicalConsultation.new(
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
    end
  end
end
