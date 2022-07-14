require "rails_helper"

RSpec.describe "patient_referrals/index", type: :view do
  let(:hospital) { create :hospital }
  let(:doctor) { create :doctor, hospital: hospital }
  let(:patient) { create :patient, doctors: [doctor] }
  let(:referred_doctor) { create :referred_doctor, doctor: doctor }

  before do
    assign(:patient_referrals, Kaminari.paginate_array([
      PatientReferral.create!(
        subject: "Subject",
        content: "MyText",
        doctor: doctor,
        patient: patient,
        referred_doctor: referred_doctor,
        hospital: hospital
      ),
      PatientReferral.create!(
        subject: "Subject",
        content: "MyText",
        doctor: doctor,
        patient: patient,
        referred_doctor: referred_doctor,
        hospital: hospital
      )
    ]).page(1))
  end

  it "renders a list of patient_referrals" do
    render
    assert_select "tr>td", text: l(PatientReferral.last.created_at, format: :not_hour), count: 2
  end
end
