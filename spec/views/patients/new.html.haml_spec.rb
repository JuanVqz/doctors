require 'rails_helper'

RSpec.describe "patients/new", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    @patient = assign(:patient, Patient.new(
      name: "Marco",
      first_name: "Chavez",
      last_name: "Castro",
      birthday: "1989-09-19",
      height: 100,
      weight: 100,
      blood_group: "ARH+",
      occupation: "Herrero",
      referred_by: "Pedro Ramos",
      place_of_birth: "Oaxaca de Juárez",
      cellphone: "951 123 45 67",
      sex: "Masculino",
      marital_status: "Casado",
      comments: "Comentario de prueba"
    ))
  end

  it "renders new patients form" do
    render

    assert_select "form[action=?][method=?]", patients_path, "post" do
      assert_select "input[name=?]", "patient[name]"
      assert_select "input[name=?]", "patient[first_name]"
      assert_select "input[name=?]", "patient[last_name]"
      assert_select "input[name=?]", "patient[birthday]"
      assert_select "input[name=?]", "patient[height]"
      assert_select "input[name=?]", "patient[weight]"
      assert_select "select[name=?]", "patient[blood_group]"
      assert_select "input[name=?]", "patient[occupation]"
      assert_select "input[name=?]", "patient[referred_by]"
      assert_select "input[name=?]", "patient[place_of_birth]"
      assert_select "input[name=?]", "patient[cellphone]"
      assert_select "select[name=?]", "patient[sex]"
      assert_select "input[name=?]", "patient[marital_status]"
      assert_select "textarea[name=?]", "patient[comments]"
    end
  end
end
