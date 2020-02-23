namespace :change_to_appoinment do
  desc "Change medical_consultation model to appoiment model"
  task run: :environment do
    imported_general = 0
    doctors.each do |doctor|
      imported_by_doctor = 0
      count = 0
      doctor.medical_consultations.each do |mc|
        appoinment = create_appoinment(mc, doctor)
        if appoinment.errors.any?
          puts "#{appoinment.errors.full_messages.join(",")}"
          abort
        end

        imported_by_doctor += 1 if appoinment.persisted?
        count += 1
        puts "#{count} | #{appoinment.id} - #{appoinment.patient}"
      end
      imported_general += imported_by_doctor
      puts "==================================================="
      puts "Imported by doctor #{doctor}: #{imported_by_doctor}"
    end
    puts "Imported general: #{imported_general}"
  end

  def create_appoinment(mc, doctor)
    note = build_note mc
    patient = Patient.unscoped.find mc.patient_id
    Appoinment.create(reason: mc.reason, note: note, prescription: mc.prescription,
                      recommendations: mc.recommendation, doctor: doctor,
                      patient: patient, imc: mc.imc, weight: mc.weight,
                      height: mc.height, blood_pressure: mc.blood_pressure,
                      heart_rate: mc.heart_rate, breathing_rate: mc.breathing_rate,
                      temperature: mc.temperature, glycaemia: mc.glycaemia,
                      sat_02: mc.sat_02, cost: mc.cost, cabinet_results: mc.lab_results,
                      histopathology: mc.histopathology, created_at: mc.created_at,
                      updated_at: mc.updated_at)
  end

  def build_note mc
    note = ""
    note << "Subjetivo:<br/>"
    note << mc.subjetive.to_s
    note << "Objetivo:<br/>"
    note << mc.objetive.to_s
    note << "Analisis:<br/>"
    note << mc.observations.to_s
    note << "Plan:<br/>"
    note << mc.plan.to_s
    note << "Pronostico:<br/>"
    note << mc.treatment.to_s
    note << "Diagnostico:<br/>"
    note << mc.diagnosis.to_s
    note << "Otros:<br/>"
    note << mc.comments.to_s
    note
  end

  def doctors
    @doctors || Doctor.unscoped.all.includes(:medical_consultations)
  end
end
