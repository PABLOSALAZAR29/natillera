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

ActiveRecord::Schema[8.0].define(version: 2026_11_18_020119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "ciclos", force: :cascade do |t|
    t.string "nombre", null: false
    t.date "fecha_inicio", null: false
    t.date "fecha_fin", null: false
    t.integer "ahorro_minimo", default: 100000, null: false
    t.integer "tasa_prestamo", default: 10, null: false
    t.integer "multa_diaria", default: 1000, null: false
    t.integer "dias_gracia", default: 2, null: false
    t.integer "estado", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado"], name: "index_ciclos_on_unico_activo", unique: true, where: "(estado = 0)"
  end

  create_table "inscripciones", force: :cascade do |t|
    t.bigint "persona_id", null: false
    t.bigint "ciclo_id", null: false
    t.integer "valor_ahorro", null: false
    t.integer "periodicidad", default: 0, null: false
    t.integer "estado", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ciclo_id"], name: "index_inscripciones_on_ciclo_id"
    t.index ["persona_id"], name: "index_inscripciones_on_persona_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "documento", null: false
    t.string "celular", null: false
    t.integer "tipo", default: 0, null: false
    t.boolean "activo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["documento"], name: "index_personas_on_documento", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.integer "rol", default: 0, null: false
    t.bigint "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["persona_id"], name: "index_users_on_persona_id", unique: true
  end

  add_foreign_key "inscripciones", "ciclos"
  add_foreign_key "inscripciones", "personas"
  add_foreign_key "sessions", "users"
  add_foreign_key "users", "personas"
end
