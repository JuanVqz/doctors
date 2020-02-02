# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_02_163813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "colony"
    t.string "postal_code"
    t.string "municipality"
    t.string "state", default: "Oaxaca"
    t.string "country", default: "México"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "bentos", force: :cascade do |t|
    t.string "code"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_bentos_on_patient_id"
  end

  create_table "clinic_histories", force: :cascade do |t|
    t.text "description_diabetes"
    t.text "description_hypertension"
    t.text "description_allergic"
    t.text "description_traumatic"
    t.text "description_transfusion"
    t.text "description_surgical"
    t.text "description_drug_addiction"
    t.text "description_hereditary"
    t.text "description_cancer"
    t.text "description_other"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_clinic_histories_on_patient_id"
  end

  create_table "doctors_patients", id: false, force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.index ["doctor_id", "patient_id"], name: "index_doctors_patients_on_doctor_id_and_patient_id"
    t.index ["patient_id", "doctor_id"], name: "index_doctors_patients_on_patient_id_and_doctor_id"
  end

  create_table "hospitalizations", force: :cascade do |t|
    t.date "starting"
    t.date "ending"
    t.decimal "days_of_stay"
    t.text "reason_for_hospitalization", default: ""
    t.text "treatment", default: ""
    t.bigint "doctor_id"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_hospitalizations_on_doctor_id"
    t.index ["patient_id"], name: "index_hospitalizations_on_patient_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.string "description"
    t.integer "plan", default: 0, null: false
    t.text "about"
    t.text "schedule"
    t.string "tags"
    t.string "facebook", default: "https://www.facebook.com/"
    t.string "twitter", default: "https://twitter.com/?lang=es"
    t.string "linkedin", default: "https://www.linkedin.com/"
    t.string "maps", default: "https://www.google.com/maps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medical_consultations", force: :cascade do |t|
    t.text "reason"
    t.text "subjetive"
    t.text "objetive"
    t.text "plan"
    t.text "diagnosis"
    t.text "treatment"
    t.text "observations"
    t.text "prescription"
    t.text "lab_results"
    t.text "histopathology"
    t.text "comments"
    t.bigint "doctor_id"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "imc", default: "0.0"
    t.decimal "weight", default: "0.0"
    t.decimal "height", default: "0.0"
    t.index ["doctor_id"], name: "index_medical_consultations_on_doctor_id"
    t.index ["patient_id"], name: "index_medical_consultations_on_patient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "place_of_birth"
    t.string "sex"
    t.string "cellphone"
    t.decimal "height"
    t.decimal "weight"
    t.string "blood_group"
    t.string "professional_card"
    t.string "specialty"
    t.string "occupation"
    t.string "referred_by"
    t.integer "role", default: 1, null: false
    t.string "type"
    t.boolean "active", default: true
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hospital_id"
    t.string "marital_status"
    t.text "comments"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["hospital_id"], name: "index_users_on_hospital_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bentos", "users", column: "patient_id"
  add_foreign_key "clinic_histories", "users", column: "patient_id"
  add_foreign_key "hospitalizations", "users", column: "doctor_id"
  add_foreign_key "hospitalizations", "users", column: "patient_id"
  add_foreign_key "medical_consultations", "users", column: "doctor_id"
  add_foreign_key "medical_consultations", "users", column: "patient_id"
end
