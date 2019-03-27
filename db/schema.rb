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

ActiveRecord::Schema.define(version: 4) do

  create_table "character_attributes", force: :cascade do |t|
    t.integer "character_id"
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.integer "max_hitpoints"
    t.integer "experience_points"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.string "char_class"
    t.string "race"
    t.integer "money"
  end

  create_table "equipments", force: :cascade do |t|
    t.string "name"
    t.string "equipment_category"
    t.integer "cost"
    t.integer "weight"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "character_id"
    t.integer "equipment_id"
  end

end
