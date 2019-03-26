require_relative '../config/equip_api.rb'

Character.destroy_all
Inventory.destroy_all
Equipment.destroy_all
CharacterAttribute.destroy_all

seed_equip_table

kellog = Character.create(name: "Kellog Tubbybuddy", level: 3, char_class: "Rogue", race: "Orc", money: 2000)
lockheim = Character.create(name: "Lockheim Superiorace", level: 1, char_class: "Ranger", race: "Elf", money: 2000)
chad = Character.create(name: "Chad Brosef", level: 5, char_class: "Barbarian", race: "Human", money: 2000)

# lamp = Equipment.create(name: "Lamp", equipment_category: "Adventuring Gear", cost: 50, weight: 1)
# crossbow = Equipment.create(name: "Crossbow", equipment_category: "Weapon", cost: 7500, weight: 3)
# javelin = Equipment.create(name: "Javelin", equipment_category: "Weapon", cost: 50, weight: 2)

kellog_inv1 = Inventory.create(character_id: kellog.id, equipment_id: nil)
lockheim_inv1 = Inventory.create(character_id: lockheim.id, equipment_id: nil)
chad_inv1 = Inventory.create(character_id: chad.id, equipment_id: nil)
chad_inv2 = Inventory.create(character_id: chad.id, equipment_id: nil)

kellog_stats = CharacterAttribute.create(character_id: kellog.id, strength: 15, dexterity: 10, constitution: 8, intelligence: 14, wisdom: 4, charisma: 20, max_hitpoints: 12, experience_points: 300)
lockheim_stats = CharacterAttribute.create(character_id: lockheim.id, strength: 10, dexterity: 10, constitution: 5, intelligence: 8, wisdom: 16, charisma: 3, max_hitpoints: 25, experience_points: 100)
chad_stats = CharacterAttribute.create(character_id: chad.id, strength: 20, dexterity: 10, constitution: 18, intelligence: 2, wisdom: 1, charisma: 1, max_hitpoints: 40, experience_points: 500)