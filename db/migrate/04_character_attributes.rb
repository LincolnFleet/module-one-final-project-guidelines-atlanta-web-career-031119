class CharacterAttributes < ActiveRecord::Migration[5.1]
    def change
        create_table :character_attributes do |t|
            t.integer   :character_id
            t.integer   :strength
            t.integer   :dexterity
            t.integer   :constitution
            t.integer   :intelligence
            t.integer   :wisdom
            t.integer   :charisma
            t.integer   :max_hitpoints
            t.integer   :experience_points
        end
    end
end