require 'rails_helper'

RSpec.describe "hospitalizations/new", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  before(:each) do
    assign(:hospitalization, Hospitalization.new(
      :starting => "2018-11-10",
      :ending => "2018-11-12",
      :days_of_stay => "2.0",
      :reason_for_hospitalization => "Razon",
      :treatment => "Tratamiento",
      :doctor_id => doctor.id,
      :patient_id => patient.id,
    ))
  end

  it "renders new hospitalization form" do
    render

    assert_select "form[action=?][method=?]", hospitalizations_path, "post" do
      assert_select "select[name=?]", "hospitalization[patient_id]"
      assert_select "input[name=?]", "hospitalization[days_of_stay]"
      assert_select "textarea[name=?]", "hospitalization[reason_for_hospitalization]"
      assert_select "textarea[name=?]", "hospitalization[treatment]"
    end
  end
end
