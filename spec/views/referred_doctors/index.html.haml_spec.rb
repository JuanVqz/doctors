require "rails_helper"

RSpec.describe "referred_doctors/index" do
  let(:hospital) { create(:hospital, subdomain: "ursula") }
  let(:doctor) { create(:doctor, hospital_id: hospital.id) }

  before do
    assign(:referred_doctors, Kaminari.paginate_array([
      ReferredDoctor.create!(
        full_name: "Full Name",
        specialty: "Specialty",
        doctor: doctor
      ),
      ReferredDoctor.create!(
        full_name: "Full Name",
        specialty: "Specialty",
        doctor: doctor
      )
    ]).page(1))
  end

  it "renders a list of referred_doctors" do
    render
    assert_select "tr>td", text: "Full Name".to_s, count: 2
    assert_select "tr>td", text: "Specialty".to_s, count: 2
  end
end
