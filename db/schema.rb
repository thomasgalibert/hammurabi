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

ActiveRecord::Schema[7.1].define(version: 2023_11_30_091111) do
  create_table "action_text_rich_texts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "kind"
    t.string "last_name"
    t.string "first_name"
    t.string "company_name"
    t.string "business_number"
    t.string "vat_number"
    t.string "email"
    t.string "phone"
    t.text "address"
    t.string "zip_code"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "main", default: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "conventions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dossier_id", null: false
    t.string "title"
    t.date "date"
    t.integer "forfait_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dossier_id"], name: "index_conventions_on_dossier_id"
    t.index ["user_id"], name: "index_conventions_on_user_id"
  end

  create_table "documents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dossier_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dossier_id"], name: "index_documents_on_dossier_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "dossier_contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "dossier_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_dossier_contacts_on_contact_id"
    t.index ["dossier_id"], name: "index_dossier_contacts_on_dossier_id"
  end

  create_table "dossiers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "state"
    t.text "description"
    t.string "category"
    t.string "court"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "viewed_at"
    t.index ["user_id"], name: "index_dossiers_on_user_id"
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dossier_id", null: false
    t.string "title"
    t.text "description"
    t.string "kind"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dossier_id"], name: "index_events_on_dossier_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "factures", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "total_ht_cents"
    t.integer "total_ttc_cents"
    t.date "date"
    t.integer "numero"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "locked", default: false
    t.bigint "emetteur_id", null: false
    t.bigint "dossier_id", null: false
    t.bigint "contact_id", null: false
    t.date "date_fin_validite"
    t.bigint "user_id", null: false
    t.string "payment_status"
    t.index ["contact_id"], name: "index_factures_on_contact_id"
    t.index ["dossier_id"], name: "index_factures_on_dossier_id"
    t.index ["emetteur_id"], name: "index_factures_on_emetteur_id"
    t.index ["user_id"], name: "index_factures_on_user_id"
  end

  create_table "lignes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.integer "quantite"
    t.integer "prix_unitaire_cents"
    t.float "tva"
    t.integer "total_ht_cents"
    t.integer "total_ttc_cents"
    t.string "facturable_type", null: false
    t.bigint "facturable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "reduction"
    t.integer "total_tva_cents"
    t.integer "row_order"
    t.string "unit"
    t.index ["facturable_type", "facturable_id"], name: "index_lignes_on_facturable"
  end

  create_table "notes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dossier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dossier_id"], name: "index_notes_on_dossier_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "payments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "facture_id", null: false
    t.bigint "user_id", null: false
    t.integer "amount_cents"
    t.date "issued_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facture_id"], name: "index_payments_on_facture_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "todos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "todoable_type", null: false
    t.bigint "todoable_id", null: false
    t.bigint "user_id", null: false
    t.string "name"
    t.boolean "done", default: false
    t.date "due_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
    t.index ["todoable_type", "todoable_id"], name: "index_todos_on_todoable"
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "firm"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contacts", "users"
  add_foreign_key "conventions", "dossiers"
  add_foreign_key "conventions", "users"
  add_foreign_key "documents", "dossiers"
  add_foreign_key "documents", "users"
  add_foreign_key "dossier_contacts", "contacts"
  add_foreign_key "dossier_contacts", "dossiers"
  add_foreign_key "dossiers", "users"
  add_foreign_key "events", "dossiers"
  add_foreign_key "events", "users"
  add_foreign_key "factures", "contacts"
  add_foreign_key "factures", "dossiers"
  add_foreign_key "factures", "users"
  add_foreign_key "factures", "users", column: "emetteur_id"
  add_foreign_key "notes", "dossiers"
  add_foreign_key "notes", "users"
  add_foreign_key "payments", "factures"
  add_foreign_key "payments", "users"
  add_foreign_key "todos", "users"
end
