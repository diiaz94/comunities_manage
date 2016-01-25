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

ActiveRecord::Schema.define(version: 20151115042408) do

  create_table "comunities", force: true do |t|
    t.string   "rif",          null: false
    t.string   "cod_registro"
    t.string   "nombre"
    t.string   "catastro"
    t.string   "sector"
    t.text     "direccion"
    t.integer  "parish_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comunities", ["parish_id"], name: "index_comunities_on_parish_id"
  add_index "comunities", ["rif"], name: "index_comunities_on_rif", unique: true

  create_table "families", force: true do |t|
    t.string   "nombre_casa"
    t.string   "numero_casa", null: false
    t.string   "telefono"
    t.text     "direccion"
    t.string   "slug"
    t.integer  "comunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "families", ["comunity_id"], name: "index_families_on_comunity_id"
  add_index "families", ["numero_casa"], name: "index_families_on_numero_casa", unique: true

  create_table "jobs", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "slug"
    t.integer  "job_id"
    t.integer  "comunity_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["comunity_id"], name: "index_members_on_comunity_id"
  add_index "members", ["job_id"], name: "index_members_on_job_id"
  add_index "members", ["profile_id"], name: "index_members_on_profile_id"

  create_table "parishes", force: true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.integer  "town_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parishes", ["town_id"], name: "index_parishes_on_town_id"

  create_table "profiles", force: true do |t|
    t.string   "cedula"
    t.string   "primer_nombre"
    t.string   "segundo_nombre"
    t.string   "primer_apellido"
    t.string   "segundo_apellido"
    t.string   "email"
    t.string   "telefono"
    t.date     "fecha_ing"
    t.date     "fecha_nac"
    t.string   "slug"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["family_id"], name: "index_profiles_on_family_id"

  create_table "requests", force: true do |t|
    t.integer  "type_request_id"
    t.integer  "status_request_id"
    t.integer  "comunity_id"
    t.integer  "profile_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "status_requests", force: true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "towns", force: true do |t|
    t.string   "nombre"
    t.string   "slug"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "towns", ["state_id"], name: "index_towns_on_state_id"

  create_table "type_requests", force: true do |t|
    t.string   "nombre"
    t.text     "formato"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "cedula",           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "slug"
    t.integer  "profile_id"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["cedula"], name: "index_users_on_cedula", unique: true
  add_index "users", ["profile_id"], name: "index_users_on_profile_id"
  add_index "users", ["type_id"], name: "index_users_on_type_id"

end
