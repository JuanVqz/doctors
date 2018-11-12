FactoryBot.define do
  factory :clinic_history do
    description_diabetes { "MyText" }
    description_hypertension { "MyString" }
    description_allergic { "MyText" }
    description_traumatic { "MyText" }
    description_transfusion { "MyText" }
    description_surgical { "MyText" }
    description_drug_addiction { "MyText" }
    description_hereditary { "MyText" }
    description_cancer { "MyText" }
    description_other { "MyText" }
    patient { nil }
  end
end
