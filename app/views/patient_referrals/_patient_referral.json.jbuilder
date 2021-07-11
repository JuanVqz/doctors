json.extract! patient_referral, :id, :subject, :content, :doctor_id, :referred_doctor_id, :hospital_id, :created_at, :updated_at
json.url patient_referral_url(patient_referral, format: :json)
