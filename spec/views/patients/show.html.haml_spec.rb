require 'rails_helper'

RSpec.describe "patients/show", type: :view do
  before(:each) do
    @patient = assign(:patient, Patient.create!(
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
      sex: "Masculino"
    ))
    @address = create :address, addressable: @patient
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Marco/)
    expect(rendered).to match(/Chavez/)
    expect(rendered).to match(/Castro/)
    expect(rendered).to match(/1989-09-19/)
    expect(rendered).to match(/100/)
    expect(rendered).to match(/ARH+/)
    expect(rendered).to match(/Herrero/)
    expect(rendered).to match(/Pedro/)
    expect(rendered).to match(/Oaxaca/)
    expect(rendered).to match(/951/)
    expect(rendered).to match(/Masculino/)
  end
end
