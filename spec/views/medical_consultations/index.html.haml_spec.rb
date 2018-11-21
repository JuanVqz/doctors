require 'rails_helper'

RSpec.describe "medical_consultations/index", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    assign(:medical_consultations, Kaminari.paginate_array([
      MedicalConsultation.create!(
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
      ),
      MedicalConsultation.create!(
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
      )
    ]).page(1))
  end

  it "renders a list of medical_consultations" do
    render
    assert_select "tr>td", :text => "Marco Chavez Castro".to_s, :count => 2
  end
end
