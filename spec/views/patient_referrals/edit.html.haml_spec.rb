require "rails_helper"

RSpec.describe "patient_referrals/edit", type: :view do
  let(:hospital) { create :hospital }
  let(:doctor) { create :doctor, hospital: hospital }
  let(:patient) { create :patient, doctors: [doctor] }
  let(:referred_doctor) { create :referred_doctor, doctor: doctor }

  before do
    @patient_referral = assign(:patient_referral, PatientReferral.create!(
      subject: "MyString",
      content: "MyText",
      patient: patient,
      doctor: doctor,
      referred_doctor: referred_doctor,
      hospital: hospital
    ))
  end

  it "renders the edit patient_referral form" do
    render

    assert_select "form[action=?][method=?]", patient_referral_path(@patient_referral), "post" do
      assert_select "input[name=?]", "patient_referral[subject]"

      assert_select "input[name=?]", "patient_referral[content]"

      assert_select "select[name=?]", "patient_referral[patient_id]"

      assert_select "select[name=?]", "patient_referral[referred_doctor_id]"

      assert_select "select[name=?]", "patient_referral[importance]"
    end
  end
end
