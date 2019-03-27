class Inventory < ActiveRecord::Base
    self.table_name = "inventories"
    belongs_to :character
    belongs_to :equipment
end