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

ActiveRecord::Schema[8.0].define(version: 2026_11_18_010648) do
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
end
