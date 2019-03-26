class CreateInventories < ActiveRecord::Migration[5.1]
    def change
        create_table :inventories do |t|
            t.integer   :character_id
            t.integer   :equipment_id
        end
    end
end