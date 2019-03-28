class Equipment < ActiveRecord::Base
    self.table_name = "equipments"
    has_many :characters, through: :inventories

    def is_weapon?
        self.equipment_category == "Weapon" 
    end

    # How many characters own this item
    def how_many_own
        characters = Inventory.where(equipment_id: self.id)
        characters.uniq.size
    end

    # How many instances of an item exist
    def how_many_exist?
        items = Inventory.where(equipment_id: self.id)
        items.size
    end

    # Which item is owned by the most characters
    def self.most_owned_item
        total = 0
        item = nil
        Equipment.all.each do |x|
            amt = x.how_many_own
            if amt > total
                total = amt 
                item = x
            end
        end
        item
    end

    # Most popular item of category ...
    def self.most_popular_weapon
        weapons = []
        Inventory.all.each do |x|
            item = Equipment.find(x.equipment_id)
            weapons << item if item.is_weapon? 
        end
        total = 0
        popular_weapon = nil
        weapons.uniq.each do |x|
            i = x.how_many_own
            if i > total 
                total = i
                popular_weapon = x
            end
        end
        popular_weapon
    end


end
