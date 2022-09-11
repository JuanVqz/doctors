require "rails_helper"

RSpec.describe "hospitalizations/index", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  before do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    assign(:hospitalizations, Kaminari.paginate_array([
      Hospitalization.create!(
        starting: "2018-11-10",
        ending: "2018-11-12",
        days_of_stay: "2.00",
        reason_for_hospitalization: "Razon",
        treatment: "Tratamiento",
        doctor_id: doctor.id,
        patient_id: patient.id
      ),
      Hospitalization.create!(
        starting: "2018-11-10",
        ending: "2018-11-12",
        days_of_stay: "2.00",
        reason_for_hospitalization: "Razon",
        treatment: "Tratamiento",
        doctor_id: doctor.id,
        patient_id: patient.id
      )
    ]).page(1))
  end

  it "renders a list of hospitalizations" do
    render
    assert_select "tr>td", text: "2018-11-10".to_s, count: 2
    assert_select "tr>td", text: "2018-11-12".to_s, count: 2
  end
end
