require "rails_helper"

RSpec.describe DoctorPolicy do
  subject { described_class }

  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:admin) { create :doctor, role: "admin", hospital: hospital }
  let(:doctor) { create :doctor, role: "doctor", hospital: hospital }
  let(:doctors) { create_list :doctor, 4, hospital: hospital }

  permissions ".scope" do
    before do
      allow(Hospital).to receive(:current_id).and_return hospital.id
      doctors
    end

    context "with admin" do
      let(:policy_scope) { DoctorPolicy::Scope.new(admin, Doctor).resolve }

      it "responds all doctors" do
        expect(policy_scope.count).to eq 5
      end
    end

    context "with doctor" do
      let(:policy_scope) { DoctorPolicy::Scope.new(doctor, Doctor).resolve }

      it "responds raise error" do
        expect { policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :new?, :create? do
    it "grants access if doctor is an admin" do
      hospital.plan = :medium
      expect(subject).to permit(admin, Doctor.new)
    end

    it "denies access if doctor is doctor" do
      expect(subject).not_to permit(doctor, Doctor.new)
    end
  end

  permissions :show?, :edit?, :update? do
    it "grants access if doctor is an admin" do
      expect(subject).to permit(admin, doctor)
    end

    it "denies access if doctor is doctor" do
      expect(subject).not_to permit(doctor, admin)
    end
  end
end
