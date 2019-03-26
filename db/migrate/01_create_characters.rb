class CreateCharacters < ActiveRecord::Migration[5.1]
    def change
        create_table :characters do |t|
            t.string    :name
            t.integer   :level
            t.string    :char_class
            t.string    :race
            t.integer   :money
        end
    end
end