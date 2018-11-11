json.extract! hospitalization, :id, :starting, :ending, :days_of_stay, :reason_for_hospitalization, :treatment, :doctor_id, :patient_id, :hospital_id, :created_at, :updated_at
json.url hospitalization_url(hospitalization, format: :json)
