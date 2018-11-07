FactoryBot.define do
  factory :address do
    street { "Cuahutemoc" }
    number { "12" }
    colony { "Centro" }
    postal_code { "68000" }
    municipality { "Oaxaca" }
    state { "Oaxaca" }
    country { "México" }
    addressable { nil }
  end
end
