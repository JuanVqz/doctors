require "rails_helper"

RSpec.describe Doctor do
  it { should belong_to :hospital }
  it { should have_and_belong_to_many :patients }
  it { should have_many :medical_consultations }
  it { should have_many :appoinments }
  it { should have_many :hospitalizations }
  it { should have_many :referred_doctors }

  it { should validate_presence_of :name }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :specialty }

  describe "has a role" do
    context "can use :doctor or :admin role" do
      let(:doctor) { build(:doctor, role: :doctor) }

      it "is a doctor role" do
        doctor.save
        expect(doctor.role).to eq "doctor"
      end

      it "is an admin role" do
        doctor.role = "admin"
        doctor.save
        expect(doctor.role).to eq "admin"
      end
    end

    context "can not use :patient role" do
      let(:doctor) { build(:doctor, :patient) }

      it "is not a patient role" do
        messages = ["no puede tener el rol paciente"]

        expect(doctor).not_to be_valid
        expect(doctor.errors.messages[:role]).to eq messages
      end
    end
  end
end
