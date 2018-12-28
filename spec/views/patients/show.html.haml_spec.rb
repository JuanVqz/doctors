require 'rails_helper'

RSpec.describe "patients/show", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
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
      sex: "Masculino",
      hospital_id: doctor.hospital.id,
      doctors: [doctor]
    ))

    @medical_consultations = create_list :medical_consultation, 2, doctor: doctor, patient: @patient
    assign(:medical_consultations, Kaminari.paginate_array(@medical_consultations).page(1))

    @hospitalizations = create_list :hospitalization, 2, doctor: doctor, patient: @patient
    assign(:hospitalizations, Kaminari.paginate_array(@hospitalizations).page(1))

    @address = create :address, addressable: @patient
    @clinic_history = create :clinic_history, patient: @patient
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Marco/)
    expect(rendered).to match(/Chavez/)
    expect(rendered).to match(/Castro/)
    expect(rendered).to match(/1989-09-19/)
    expect(rendered).to match(/ARH+/)
    expect(rendered).to match(/Herrero/)
    expect(rendered).to match(/Pedro/)
    expect(rendered).to match(/Oaxaca/)
    expect(rendered).to match(/951/)
    expect(rendered).to match(/Masculino/)
  end
end
