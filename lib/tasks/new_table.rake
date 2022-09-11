namespace :new_table do
  desc "Change medical_consultation model to appoiment model"
  task appoinments: :environment do
    imported_general = 0
    doctors.each do |doctor|
      imported_by_doctor = 0
      count = 0
      doctor.medical_consultations.each do |mc|
        appoinment = create_appoinment(mc, doctor)
        if appoinment.errors.any?
          puts appoinment.errors.full_messages.join(",").to_s
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

  desc "Change clinic_history model to patient attributes"
  task patients: :environment do
    count = 0
    patients.each do |p|
      next if p.clinic_history.nil?

      patient = update_patient p
      patient.save
      if patient.errors.any?
        puts patient.errors.full_messages.join(", ").to_s
        abort
      end
      count += 1 if patient.persisted?
      puts "Patient: #{patient.id} #{patient}"
    end
    puts "Patients updated: #{count}"
  end

  def update_patient p
    p.allergies = p.clinic_history.description_drug_addiction.to_s
    p.pathological_background = p.clinic_history.description_hypertension.to_s
    p.non_pathological_background = p.clinic_history.description_allergic.to_s
    p.gyneco_obstetric_background = p.clinic_history.description_traumatic.to_s
    p.system_background = p.clinic_history.description_traumatic.to_s
    p.family_inheritance_background = p.clinic_history.description_hereditary.to_s
    p.physic_exploration = p.clinic_history.description_surgical.to_s
    p.other_background = other_background(p.clinic_history)
    p
  end

  def other_background(ch)
    other = ""
    other << "Antencedentes Diabetes:<br/>"
    other << ch.description_diabetes.to_s
    other << "Antencedentes Cancer:<br/>"
    other << ch.description_cancer.to_s
    other << "Antencedentes Otros:<br/>"
    other << ch.description_other.to_s
    other
  end

  def patients
    @patients || Patient.unscoped.all.includes(:clinic_history)
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
