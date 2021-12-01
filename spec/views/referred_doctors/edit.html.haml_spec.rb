require "rails_helper"

RSpec.describe "referred_doctors/edit", type: :view do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  before(:each) do
    @referred_doctor = assign(:referred_doctor, ReferredDoctor.create!(
      full_name: "MyString",
      specialty: "MyString",
      doctor: doctor
    ))
  end

  it "renders the edit referred_doctor form" do
    render

    assert_select "form[action=?][method=?]", referred_doctor_path(@referred_doctor), "post" do
      assert_select "input[name=?]", "referred_doctor[full_name]"

      assert_select "input[name=?]", "referred_doctor[specialty]"
    end
  end
end
