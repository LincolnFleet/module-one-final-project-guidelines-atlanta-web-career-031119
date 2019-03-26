class CreateEquipments < ActiveRecord::Migration[5.1]
    def change
        create_table :equipments do |t|
            t.string    :name
            t.string    :equipment_category
            t.integer   :cost
            t.integer   :weight
        end
    end
end