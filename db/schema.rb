# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160721153021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actividad_publicas", force: :cascade do |t|
    t.date     "fecha"
    t.string   "descripcion"
    t.string   "link"
    t.string   "lugar"
    t.integer  "partido_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "actividad_publicas", ["partido_id"], name: "index_actividad_publicas_on_partido_id", using: :btree

  create_table "acuerdos", force: :cascade do |t|
    t.string   "numero"
    t.date     "fecha"
    t.string   "tipo"
    t.string   "tema"
    t.string   "region"
    t.integer  "organo_interno_id"
    t.string   "documento_file_name"
    t.string   "documento_content_type"
    t.integer  "documento_file_size"
    t.datetime "documento_updated_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "partido_id"
  end

  add_index "acuerdos", ["organo_interno_id"], name: "index_acuerdos_on_organo_interno_id", using: :btree
  add_index "acuerdos", ["partido_id"], name: "index_acuerdos_on_partido_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "is_superadmin"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "afiliacions", force: :cascade do |t|
    t.integer  "hombres"
    t.integer  "mujeres"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "partido_id"
    t.integer  "region_id"
    t.date     "fecha_datos"
    t.integer  "ano_nacimiento"
    t.integer  "otros"
  end

  add_index "afiliacions", ["partido_id"], name: "index_afiliacions_on_partido_id", using: :btree
  add_index "afiliacions", ["region_id"], name: "index_afiliacions_on_region_id", using: :btree

  create_table "cargos", force: :cascade do |t|
    t.integer  "persona_id"
    t.integer  "tipo_cargo_id"
    t.integer  "partido_id"
    t.integer  "region_id"
    t.integer  "comuna_id"
    t.integer  "circunscripcion_id"
    t.integer  "distrito_id"
    t.date     "fecha_desde"
    t.date     "fecha_hasta"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "cargos", ["circunscripcion_id"], name: "index_cargos_on_circunscripcion_id", using: :btree
  add_index "cargos", ["comuna_id"], name: "index_cargos_on_comuna_id", using: :btree
  add_index "cargos", ["distrito_id"], name: "index_cargos_on_distrito_id", using: :btree
  add_index "cargos", ["partido_id"], name: "index_cargos_on_partido_id", using: :btree
  add_index "cargos", ["persona_id"], name: "index_cargos_on_persona_id", using: :btree
  add_index "cargos", ["region_id"], name: "index_cargos_on_region_id", using: :btree
  add_index "cargos", ["tipo_cargo_id"], name: "index_cargos_on_tipo_cargo_id", using: :btree

  create_table "categoria_financieras", force: :cascade do |t|
    t.integer  "partido_id"
    t.integer  "documento_id"
    t.date     "fecha"
    t.string   "titulo"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "circunscripcions", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comunas", force: :cascade do |t|
    t.integer  "provincia_id"
    t.string   "nombre"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comunas", ["provincia_id"], name: "index_comunas_on_provincia_id", using: :btree

  create_table "distritos", force: :cascade do |t|
    t.integer  "circunscripcion_id"
    t.string   "nombre"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "distritos", ["circunscripcion_id"], name: "index_distritos_on_circunscripcion_id", using: :btree

  create_table "documentos", force: :cascade do |t|
    t.string   "descripcion"
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
  end

  add_index "documentos", ["documentable_type", "documentable_id"], name: "index_documentos_on_documentable_type_and_documentable_id", using: :btree

  create_table "eleccion_internas", force: :cascade do |t|
    t.integer  "organo_interno_id"
    t.date     "fecha_eleccion"
    t.date     "fecha_limite_inscripcion"
    t.string   "cargo"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "partido_id"
  end

  add_index "eleccion_internas", ["organo_interno_id"], name: "index_eleccion_internas_on_organo_interno_id", using: :btree
  add_index "eleccion_internas", ["partido_id"], name: "index_eleccion_internas_on_partido_id", using: :btree

  create_table "eleccion_populars", force: :cascade do |t|
    t.date     "fecha_eleccion"
    t.integer  "dias"
    t.string   "cargo"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "partido_id"
  end

  add_index "eleccion_populars", ["partido_id"], name: "index_eleccion_populars_on_partido_id", using: :btree

  create_table "item_contables", force: :cascade do |t|
    t.integer  "categoria_financiera_id"
    t.string   "concepto"
    t.boolean  "dinero_publico"
    t.integer  "importe"
    t.integer  "partido_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "leys", force: :cascade do |t|
    t.string   "numero"
    t.string   "nombre"
    t.string   "enlace"
    t.string   "tags"
    t.string   "resumen"
    t.integer  "marco_general_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "leys", ["marco_general_id"], name: "index_leys_on_marco_general_id", using: :btree

  create_table "marco_generals", force: :cascade do |t|
    t.integer  "partido_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "marco_generals", ["partido_id"], name: "index_marco_generals_on_partido_id", using: :btree

  create_table "marco_internos", force: :cascade do |t|
    t.integer  "partido_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "marco_internos", ["partido_id"], name: "index_marco_internos_on_partido_id", using: :btree

  create_table "organo_internos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "funciones"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "partido_id"
  end

  add_index "organo_internos", ["partido_id"], name: "index_organo_internos_on_partido_id", using: :btree

  create_table "pacto_electorals", force: :cascade do |t|
    t.integer  "ano_eleccion"
    t.string   "nombre_pacto"
    t.string   "descripcion"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "pacto_electorals_partidos", id: false, force: :cascade do |t|
    t.integer "pacto_electoral_id", null: false
    t.integer "partido_id",         null: false
  end

  create_table "participacion_entidads", force: :cascade do |t|
    t.string   "entidad"
    t.string   "descripcion"
    t.string   "documento_file_name"
    t.string   "documento_content_type"
    t.integer  "documento_file_size"
    t.datetime "documento_updated_at"
    t.integer  "partido_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "participacion_entidads", ["partido_id"], name: "index_participacion_entidads_on_partido_id", using: :btree

  create_table "partidos", force: :cascade do |t|
    t.string   "nombre",            null: false
    t.string   "sigla",             null: false
    t.string   "lema",              null: false
    t.date     "fecha_fundacion"
    t.text     "texto"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "partidos_regions", id: false, force: :cascade do |t|
    t.integer "partido_id", null: false
    t.integer "region_id",  null: false
  end

  add_index "partidos_regions", ["partido_id", "region_id"], name: "index_partidos_regions_on_partido_id_and_region_id", using: :btree
  add_index "partidos_regions", ["region_id", "partido_id"], name: "index_partidos_regions_on_region_id_and_partido_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "admin_id"
    t.integer  "partido_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "permissions", ["admin_id"], name: "index_permissions_on_admin_id", using: :btree
  add_index "permissions", ["partido_id"], name: "index_permissions_on_partido_id", using: :btree

  create_table "personas", force: :cascade do |t|
    t.string   "genero"
    t.date     "fecha_nacimiento"
    t.string   "nivel_estudios"
    t.string   "region"
    t.integer  "ano_inicio_militancia"
    t.boolean  "afiliado"
    t.text     "bio"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.string   "nombre"
    t.string   "apellidos"
    t.integer  "partido_id"
    t.integer  "personable_id"
    t.string   "personable_type"
    t.string   "cargo"
    t.string   "distrito"
    t.string   "circunscripcion"
    t.string   "comuna"
    t.string   "telefono"
    t.string   "email"
    t.date     "fecha_desde"
    t.date     "fecha_hasta"
    t.string   "tipo"
    t.string   "intereses"
    t.string   "patrimonio"
    t.string   "rut"
  end

  add_index "personas", ["partido_id"], name: "index_personas_on_partido_id", using: :btree
  add_index "personas", ["personable_type", "personable_id"], name: "index_personas_on_personable_type_and_personable_id", using: :btree

  create_table "procedimientos", force: :cascade do |t|
    t.string   "descripcion"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "procedimentable_id"
    t.string   "procedimentable_type"
  end

  add_index "procedimientos", ["procedimentable_type", "procedimentable_id"], name: "index_procedimentable_type_and_id", using: :btree

  create_table "provincias", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "provincias", ["region_id"], name: "index_provincias_on_region_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ordinal"
  end

  create_table "requisitos", force: :cascade do |t|
    t.string   "descripcion"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "requisitable_id"
    t.string   "requisitable_type"
  end

  add_index "requisitos", ["requisitable_type", "requisitable_id"], name: "index_requisitos_on_requisitable_type_and_requisitable_id", using: :btree

  create_table "sancions", force: :cascade do |t|
    t.string   "descripcion"
    t.string   "institucion"
    t.date     "fecha"
    t.string   "documento_file_name"
    t.string   "documento_content_type"
    t.integer  "documento_file_size"
    t.datetime "documento_updated_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "partido_id"
  end

  add_index "sancions", ["partido_id"], name: "index_sancions_on_partido_id", using: :btree

  create_table "sedes", force: :cascade do |t|
    t.string   "direccion"
    t.string   "contacto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "partido_id"
    t.integer  "region_id"
  end

  add_index "sedes", ["partido_id"], name: "index_sedes_on_partido_id", using: :btree

  create_table "tipo_cargos", force: :cascade do |t|
    t.string   "titulo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "partido_id"
  end

  add_index "tipo_cargos", ["partido_id"], name: "index_tipo_cargos_on_partido_id", using: :btree

  create_table "tramites", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "persona_id"
    t.string   "documento_file_name"
    t.string   "documento_content_type"
    t.integer  "documento_file_size"
    t.datetime "documento_updated_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "partido_id"
  end

  add_index "tramites", ["partido_id"], name: "index_tramites_on_partido_id", using: :btree
  add_index "tramites", ["persona_id"], name: "index_tramites_on_persona_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "actividad_publicas", "partidos"
  add_foreign_key "acuerdos", "organo_internos"
  add_foreign_key "acuerdos", "partidos"
  add_foreign_key "afiliacions", "partidos"
  add_foreign_key "afiliacions", "regions"
  add_foreign_key "cargos", "circunscripcions"
  add_foreign_key "cargos", "comunas"
  add_foreign_key "cargos", "distritos"
  add_foreign_key "cargos", "partidos"
  add_foreign_key "cargos", "personas"
  add_foreign_key "cargos", "regions"
  add_foreign_key "cargos", "tipo_cargos"
  add_foreign_key "comunas", "provincias"
  add_foreign_key "distritos", "circunscripcions"
  add_foreign_key "eleccion_internas", "organo_internos"
  add_foreign_key "eleccion_internas", "partidos"
  add_foreign_key "eleccion_populars", "partidos"
  add_foreign_key "leys", "marco_generals"
  add_foreign_key "marco_generals", "partidos"
  add_foreign_key "marco_internos", "partidos"
  add_foreign_key "organo_internos", "partidos"
  add_foreign_key "participacion_entidads", "partidos"
  add_foreign_key "permissions", "admins"
  add_foreign_key "permissions", "partidos"
  add_foreign_key "personas", "partidos"
  add_foreign_key "provincias", "regions"
  add_foreign_key "sancions", "partidos"
  add_foreign_key "sedes", "partidos"
  add_foreign_key "tipo_cargos", "partidos"
  add_foreign_key "tramites", "partidos"
  add_foreign_key "tramites", "personas"
end
