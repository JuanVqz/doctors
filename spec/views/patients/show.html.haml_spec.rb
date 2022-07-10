require "rails_helper"

RSpec.describe "patients/show", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  before do
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
      marital_status: "Casado",
      comments: "Algo que decir",
      hospital_id: doctor.hospital.id,
      doctors: [doctor]
    ))

    @appoinments = create_list :appoinment, 2, doctor: doctor, patient: @patient
    assign(:appoinments, Kaminari.paginate_array(@appoinments).page(1))

    @hospitalizations = create_list :hospitalization, 2, doctor: doctor, patient: @patient
    assign(:hospitalizations, Kaminari.paginate_array(@hospitalizations).page(1))

    @address = create :address, addressable: @patient
    @clinic_history = create :clinic_history, patient: @patient
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Motivo/)
    expect(rendered).to match(/Prescription/)
  end
end
