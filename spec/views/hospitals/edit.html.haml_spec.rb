require "rails_helper"

RSpec.describe "hospitals/edit" do
  before do
    @hospital = assign(:hospital, Hospital.create!(
      name: "Santa Ursula",
      subdomain: "santa_ursula",
      description: "Una descripción",
      plan: "basic"
    ))
  end

  it "renders the edit hospital form" do
    render

    assert_select "form[action=?][method=?]", hospital_path(@hospital), "post" do
      assert_select "input[name=?]", "hospital[name]"
      assert_select "input[name=?]", "hospital[description]"
    end
  end
end
