FactoryBot.define do
  factory :hospitalization do
    starting { "2018-11-11" }
    ending { "2018-11-16" }
    days_of_stay { "5" }
    reason_for_hospitalization { "MyText" }
    treatment { "MyText" }

    after :build do |hospitalization|
      if hospitalization.doctor.nil?
        hospitalization.doctor = create :doctor
      end
      if hospitalization.patient.nil?
        hospitalization.patient = create :patient,
          doctors: [hospitalization.doctor]
      end
    end
  end
end
