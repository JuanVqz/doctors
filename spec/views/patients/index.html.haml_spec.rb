require "rails_helper"

RSpec.describe "patients/index", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  before(:each) do
    assign(:patients, [
      Patient.create!(
        name: "Marco",
        first_name: "Chavez",
        last_name: "Castro",
        birthday: "1989-09-19",
        height: "180.0",
        weight: "80.0",
        blood_group: "A+",
        occupation: "Herrero",
        referred_by: "Pedro Ramos",
        confirmed_at: Time.now,
        doctors: [doctor]
      ),
      Patient.create!(
        name: "José",
        first_name: "Ramirez",
        last_name: "Carrillo",
        birthday: "1989-09-19",
        height: "180.0",
        weight: "80.0",
        blood_group: "A+",
        occupation: "Industrial",
        referred_by: "Pedro Ramos",
        confirmed_at: Time.now,
        doctors: [doctor]
      )
    ])
  end

  it "renders a list of patients" do
    render
    assert_select "tr>td", :text => "Marco Chavez Castro".to_s, :count => 1
    assert_select "tr>td", :text => "José Ramirez Carrillo".to_s, :count => 1
    assert_select "tr>td", :text => "Herrero".to_s, :count => 1
    assert_select "tr>td", :text => "Industrial".to_s, :count => 1
  end
end
