require "rails_helper"

RSpec.describe "patients/index", type: :view do
  let(:doctor) { create :doctor }

  before(:each) do
    assign(:patients, Kaminari.paginate_array([
      Patient.create!(
        name: "Marco",
        first_name: "Chavez",
        last_name: "Castro",
        birthday: "1989-09-19",
        height: "180.0",
        weight: "80.0",
        blood_group: "ARH+",
        occupation: "Herrero",
        referred_by: "Pedro Ramos",
        place_of_birth: "Oaxaca de Juárez",
        cellphone: "951 123 45 67",
        sex: "Masculino",
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
        blood_group: "ARH+",
        occupation: "Industrial",
        referred_by: "Pedro Ramos",
        place_of_birth: "Oaxaca de Juárez",
        cellphone: "951 123 45 67",
        sex: "Masculino",
        confirmed_at: Time.now,
        doctors: [doctor]
      )
    ]).page(1))
  end

  it "renders a list of patients" do
    render
    assert_select "tr>td", :text => "Marco Chavez Castro".to_s, :count => 1
    assert_select "tr>td", :text => "José Ramirez Carrillo".to_s, :count => 1
  end
end
