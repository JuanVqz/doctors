json.extract! medical_consultation, :id, :reason, :subjetive, :objetive, :plan, :diagnosis, :treatment, :observations, :prescription, :lab_results, :histopathology, :comments, :doctor_id, :patient_id, :created_at, :updated_at
json.url medical_consultation_url(medical_consultation, format: :json)
