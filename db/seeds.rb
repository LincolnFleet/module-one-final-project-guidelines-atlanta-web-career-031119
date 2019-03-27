require_relative '../config/equip_api.rb'
require_relative '../app/cli_elements/cli_main.rb'

Character.destroy_all
Inventory.destroy_all
Equipment.destroy_all
CharacterAttribute.destroy_all

seed_equip_table

Character.create(name: "Kellog Tubbybuddy", level: 3, char_class: "Rogue", race: "Orc", money: 2000)
Character.create(name: "Lockheim Superiorace", level: 1, char_class: "Ranger", race: "Elf", money: 2000)
Character.create(name: "Chad Brosef", level: 5, char_class: "Barbarian", race: "Human", money: 2000)

# lamp = Equipment.create(name: "Lamp", equipment_category: "Adventuring Gear", cost: 50, weight: 1)
# crossbow = Equipment.create(name: "Crossbow", equipment_category: "Weapon", cost: 7500, weight: 3)
# javelin = Equipment.create(name: "Javelin", equipment_category: "Weapon", cost: 50, weight: 2)

# kellog_inv1 = Inventory.create(character_id: kellog.id, equipment_id: nil)
# lockheim_inv1 = Inventory.create(character_id: lockheim.id, equipment_id: nil)
# chad_inv1 = Inventory.create(character_id: chad.id, equipment_id: nil)
# chad_inv2 = Inventory.create(character_id: chad.id, equipment_id: nil)

# kellog_stats=assign_stats(kellog) 
# lockheim_stats=assign_stats(lockheim)
# chad_stats=assign_stats(chad)

