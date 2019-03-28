class Character < ActiveRecord::Base
    has_one :characterattribute
    has_many :equipments, through: :inventories

    def show_items_as_hash
        items = Inventory.where(self.id == :character_id)
        array = items.map do |x|
            Equipment.find(x).name
        end
        array_to_hash(array)
    end

    def array_to_hash(array)
        hash = {}
        array.each do |i|
            if hash.has_key?(i)
                hash[i] += 1
            else
                hash[i] = 1
            end
        end
        hash
    end

    #Delivers 
    def total_value_of_items
        total = 0
        items_hash = self.show_items_as_hash
        items_hash.each do |k,v|
            total += Equipment.find_by(name: k).cost * v
        end
        total
    end

    #Delivers integer of sum number of equipments owned by character instance
    def total_items 
        items = Inventory.where(self.id == :character_id)
        items.size
    end

    #Delivers integer describing sum of equipments owned weights
    def character_weight
        total_weight = 0
        items = Inventory.where(self.id == :character_id)
        items.each do |i|
            total_weight += i.weight
        end
        total_weight
    end

    #Delivers character instance associated with most equipments
    def self.most_items
        items = 0
        character = nil
        Character.all.each do |char|
            i = char.total_items
            if i > items
                character = char 
                items = i
            end
        end
        character
    end

    #Delivers character instance associated with fewest equipments
    def self.fewest_items
        items = 1.0/0
        character = nil
        Character.all.each do |char|
            i = char.total_items
            if i < items
                character = char 
                items = i
            end
        end
        character
    end

    #Delivers character instance with greatest cumulative sum of equipments owned weight
    def self.most_encumbered
        weight = 0
        character = nil
        Character.all.each do |char|
            w = char.character_weight
            if w > weight
                character = char 
                weight = w
            end
        end
        character
    end

end