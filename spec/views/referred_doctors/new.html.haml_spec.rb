require "rails_helper"

RSpec.describe "referred_doctors/new" do
  before do
    assign(:referred_doctor, ReferredDoctor.new(
      full_name: "MyString",
      specialty: "MyString",
      doctor: nil
    ))
  end

  it "renders new referred_doctor form" do
    render

    assert_select "form[action=?][method=?]", referred_doctors_path, "post" do
      assert_select "input[name=?]", "referred_doctor[full_name]"

      assert_select "input[name=?]", "referred_doctor[specialty]"
    end
  end
end
