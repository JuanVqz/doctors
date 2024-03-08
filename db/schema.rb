# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_08_222728) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "appoinments", force: :cascade do |t|
    t.string "reason"
    t.text "note"
    t.text "prescription"
    t.text "recommendations"
    t.bigint "doctor_id"
    t.bigint "patient_id"
    t.float "imc", default: 0.0
    t.float "weight", default: 0.0
    t.float "height", default: 0.0
    t.string "blood_pressure", default: ""
    t.float "heart_rate", default: 0.0
    t.float "breathing_rate", default: 0.0
    t.float "temperature", default: 0.0
    t.float "glycaemia", default: 0.0
    t.float "sat_02", default: 0.0
    t.float "cost", default: 0.0
    t.text "cabinet_results"
    t.text "histopathology"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["doctor_id"], name: "index_appoinments_on_doctor_id"
    t.index ["patient_id"], name: "index_appoinments_on_patient_id"
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "input_diagnosis"
    t.text "output_diagnosis"
    t.text "recommendations"
    t.bigint "referred_doctor_id"
    t.integer "status", default: 0
    t.index ["doctor_id"], name: "index_hospitalizations_on_doctor_id"
    t.index ["patient_id"], name: "index_hospitalizations_on_patient_id"
    t.index ["referred_doctor_id"], name: "index_hospitalizations_on_referred_doctor_id"
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "patient_referrals", force: :cascade do |t|
    t.string "subject"
    t.text "content"
    t.integer "importance", default: 0, null: false
    t.bigint "patient_id", null: false
    t.bigint "doctor_id", null: false
    t.bigint "referred_doctor_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_patient_referrals_on_doctor_id"
    t.index ["hospital_id"], name: "index_patient_referrals_on_hospital_id"
    t.index ["patient_id"], name: "index_patient_referrals_on_patient_id"
    t.index ["referred_doctor_id"], name: "index_patient_referrals_on_referred_doctor_id"
  end

  create_table "referred_doctors", force: :cascade do |t|
    t.string "full_name"
    t.string "specialty"
    t.bigint "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.index ["doctor_id"], name: "index_referred_doctors_on_doctor_id"
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
    t.integer "role", default: 0, null: false
    t.string "type"
    t.boolean "active", default: true
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "hospital_id"
    t.string "marital_status"
    t.text "comments"
    t.text "allergies", default: ""
    t.text "pathological_background", default: ""
    t.text "non_pathological_background", default: ""
    t.text "gyneco_obstetric_background", default: ""
    t.text "system_background", default: ""
    t.text "family_inheritance_background", default: ""
    t.text "physic_exploration", default: ""
    t.text "other_background", default: ""
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["hospital_id"], name: "index_users_on_hospital_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appoinments", "users", column: "doctor_id"
  add_foreign_key "appoinments", "users", column: "patient_id"
  add_foreign_key "hospitalizations", "referred_doctors"
  add_foreign_key "hospitalizations", "users", column: "doctor_id"
  add_foreign_key "hospitalizations", "users", column: "patient_id"
  add_foreign_key "patient_referrals", "hospitals"
  add_foreign_key "patient_referrals", "referred_doctors"
  add_foreign_key "patient_referrals", "users", column: "doctor_id"
  add_foreign_key "patient_referrals", "users", column: "patient_id"
  add_foreign_key "referred_doctors", "users", column: "doctor_id"
end
