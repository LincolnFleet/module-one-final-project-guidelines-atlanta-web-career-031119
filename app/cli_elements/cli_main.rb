require_relative './dice.rb'
require 'pry'
require 'tty-table'

def run_program
    greeting
    ask_task
end

def greeting
    clear_screen
    solid_line
    puts "\t\tHello and welcome to the character library!"
    solid_line
end

def buffer(int=1)
    int.times do
        puts "\n"
    end
end

def solid_line
    puts "------------------------------------------------------------------------"
end

def clear_screen
    system("clear")
end

def ask_task
    buffer(2)
    puts "If you would like to create a new character enter 'create'\n
If you would like ask a question about existing characters and/or items enter 'query'\n
To exit the character library, enter 'quit'"
    buffer(2)
    response = gets.chomp
    if response == "create"
        character = get_info
        assign_stats(character)
    puts "Your stats are being rolled!"
    sleeps
    sleeps
    sleeps
    sleeps
    sleeps
    show_stats(character)
    want_equip?(character)
    elsif response == "query"
        show_query_options
    elsif response == 'quit'
        exit
    else
        ask_task
    end
end 

def get_name
    clear_screen
    buffer(1)
    puts "Here we will begin the character creation process"
    puts "What is your character's name?"
    buffer()
end

def sleeps
    puts "      ."
    sleep(1)
end

def get_info
    get_name
    name = gets.chomp
    get_class
    # char_class = gets.chomp
    char_class = valid_class?(gets.chomp)
    get_race
    race = gets.chomp
    money = get_money(char_class)
    puts "Your starting money is determined by your class choice.\n
This character will be starting with #{money} copper pieces."
    character = char_instantiate(name, 1, char_class, race, money)
end

def valid_class?(user_entry)
    array = ["barbarian", "bard", "cleric", "druid", "fighter", "monk",
    "paladin", "ranger", "rogue", "sorcerer", "warlock", "wizard"]
    if array.include?(user_entry.downcase)
        return user_entry.downcase.capitalize
    else
        puts "That class name is not recognized.\nPlease choose a class from the list."
        buffer()
        valid_class?(gets.chomp)
    end
end

def get_class
    clear_screen
    buffer(1)
    puts "What is your character's class?\n
    Choose from:\n
    [Barbarian] [Bard] [Cleric] [Druid] [Fighter] [Monk] \n
    [Paladin] [Ranger] [Rogue] [Sorcerer] [Warlock] [Wizard]"
    buffer()
end

def get_race
    clear_screen
    buffer(1)
    puts "What is your character's race?\n
    You may create your own or choose from these standard options:\n
    [Drow] [Dwarf] [Elf] [Halfling] [Human]\n
    [Dragonborn] [Gnome] [Half-Elf] [Half-Orc] [Tiefling]"
    buffer()
end

def get_money(char_class)
    clear_screen
    wallet = 0
    case char_class
    when "Barbarian"
        2.times {|x| wallet += roll_d4}
    when "Bard"
        5.times {|x| wallet += roll_d4}
    when "Cleric"
        5.times {|x| wallet += roll_d4}
    when "Druid"
        2.times {|x| wallet += roll_d4}
    when "Fighter"
        5.times {|x| wallet += roll_d4}
    when "Monk"
        5.times {|x| wallet += roll_d4}
        return wallet * 100
    when "Paladin"
        5.times {|x| wallet += roll_d4}
    when "Ranger"
        5.times {|x| wallet += roll_d4}
    when "Rogue"
        4.times {|x| wallet += roll_d4}
    when "Sorcerer"
        3.times {|x| wallet += roll_d4}
    when "Warlock"
        4.times {|x| wallet += roll_d4}
    when "Wizard"
        4.times {|x| wallet += roll_d4}
    else
    end
    wallet * 1000
end

def char_instantiate(n, l, c_c, r, m)
    Character.create(name: n, level: l, char_class: c_c, race: r, money: m)
end

######################################
#STATS

def gen_hitpoints(char_class)
    hitpoints = 0
    case char_class
    when "Barbarian"
        hitpoints += 12
    when "Bard"
        hitpoints += 8
    when "Cleric"
        hitpoints += 8
    when "Druid"
        hitpoints += 8
    when "Fighter"
        hitpoints += 10
    when "Monk"
        hitpoints += 8
    when "Paladin"
        hitpoints += 10
    when "Ranger"
        hitpoints += 10
    when "Rogue"
        hitpoints += 8
    when "Sorcerer"
        hitpoints += 6
    when "Warlock"
        hitpoints += 8
    when "Wizard"
        hitpoints += 6
    end
    hitpoints
end

def roll_stats
    array=[]
    4.times do |x|
        array << roll_d6
    end
    array.sort[1..3].inject(0) {|sum, x| sum + x}
end

def build_stats
    array=[]
    6.times do |x|
        array << roll_stats
    end
    array
end

def assign_stats(char)
    array = build_stats
    CharacterAttribute.create(
        character_id: char.id,
        strength: array[0],
        dexterity: array[1],
        constitution: array[2],
        intelligence: array[3],
        wisdom: array[4],
        charisma: array[5],
        max_hitpoints: gen_hitpoints(char.char_class),
        experience_points: 0
        )
end

def show_stats(character)
    clear_screen
    char_stats = CharacterAttribute.find_by(character_id: character.id)
    buffer()
    puts "#{character.name}'s ability scores are:\n"
    puts "Strength:      #{char_stats.strength}"
    puts "Dexterity:     #{char_stats.dexterity}"
    puts "Constitution:  #{char_stats.constitution}"
    puts "Intelligence:  #{char_stats.intelligence}"
    puts "Wisdom:        #{char_stats.wisdom}"
    puts "Charisma:      #{char_stats.charisma}"
    puts "Hit Points:    #{char_stats.max_hitpoints}"
    puts "Experience:    #{char_stats.experience_points}"
    buffer(2)
end

######################################
#EQUIP

def show_money(char_obj)
    puts "You currently have: #{char_obj.money} copper pieces."
end

def want_equip?(char_obj)
    buffer(1)
    puts "Congratulations on creating your character! \n
Would you like to buy equipment? ('y' / 'n')\n"
    buffer()
    show_money(char_obj)
    buffer
    response = gets.chomp
    if response == "y"
        equip_store(char_obj)
    else
        clear_screen
        return_to_main
        clear_screen
    end
end

def equip_store(char_obj)
    clear_screen
    solid_line
    puts "\t\t   Welcome to the equipment store!"
    solid_line
    buffer(2)
    puts "Here you can scroll through all available equipment.\n
to make a purchase, enter equipment's ID number."
    buffer(2)
    show_money(char_obj)
    puts "You may exit the store at any time by entering 'x'.\n
Press any key to enter the store."
    buffer
    STDIN.getch
    show_store(char_obj)
    buffer
end

def show_store(char_obj)
    store = construct_equipment_table
    show_equipment_table(store)
    response = gets.chomp
    if response == "x"
        want_equip?(char_obj)
    elsif response.to_i >= Equipment.all.first.id && response.to_i <= (Equipment.all.first.id) + 256
        if can_buy?(Equipment.find(response.to_i), char_obj)
            add_equip(Equipment.find(response.to_i), char_obj)
            update_char_money(Equipment.find(response.to_i), char_obj)
            new_char_obj = Character.find(char_obj.id)
            clear_screen
            another_purchase?(new_char_obj)
        else
            buffer()
            puts "You don't have enough coin!\n
            Try again."
            sleeps
            sleeps
            sleeps
            show_store(char_obj)
        end
    else
        equip_store(char_obj)
    end
end

def construct_equipment_table
    table = TTY::Table.new(header: ["Item ID", "Item Name", "Item Cost"], rows: [])
    add_to_table(table)
    table
end

def add_to_table(table)
    Equipment.all.each do |item|
        a = [item.id, item.name, item.cost]
        table << a
    end
end

def show_equipment_table(table)
    puts table.render(:basic)
end

def add_equip(equip, char)
    Inventory.create(character_id: char.id, equipment_id: equip.id)
end

def can_buy?(equip, char)
    char.money >= equip.cost
end

def update_char_money(equip_obj, char_obj)
    new_tot = char_obj.money - equip_obj.cost
    Character.update(char_obj.id, :money => new_tot)
end

def another_purchase?(char_obj)
    show_money(char_obj)
    buffer()
    puts "Would you like to make another purchase? ('y' / 'n')"
    buffer
    response = gets.chomp
    if response == "y"
        show_store(char_obj)
    elsif response == "n"
        return_to_main
    else
        another_purchase?(char_obj)
    end
end

def return_to_main
    clear_screen
    buffer()
    puts "Returning to main menu."
        sleeps
        sleeps
        sleeps
        clear_screen
        ask_task
end

##############
## Ask Questions
$query_array = ["Show the total Equipment value of a specified character",
                "Show the number of items (Equipment) that a specified character owns",
                "Show the total Equipment weight of a specified character",
                "Which character has the most items (Equipment)?",
                "Which character has the fewest items (Equipment)?",
                "Which character is the most Encumbered (heaviest)?",
                "Show how many characters own a specified (by name) item",
                "Show how many instances of a specified item exist",
                "Which item is owned by the most characters?",
                "What is the most popular weapon?",
                ]


def add_to_query_table(table, query_array)
    query_array.each_with_index do |q, index|
        table << [index + 1, q]
    end
    table
end


def query_table
    t = TTY::Table.new(header: ["Query ID", "Query Description"], rows: [])
    table = add_to_query_table(t, $query_array)
    table
end

def show_query_options
    clear_screen
    puts "Here you will have some possible options to choose from.\n
Questions that require parameter input will provide additional prompts, when selected.\n
To see options enter 'y', to return to main menu, enter 'n'"
    buffer()
    response = gets.chomp 
    clear_screen
    if response == "y"
        puts query_table.render(:basic)
        puts "\nEnter the ID of the desired query. Enter '0' to return to main menu"
        buffer()
        r = gets.chomp
        query_by_index(r.to_i)
        buffer(2)
        puts "To make another query enter 'y'. To return to main menu enter 'n'"
        buffer()
        response = gets.chomp
        if response == "y"  
            show_query_options
        else
            ask_task
        end
    elsif response == "n"
        ask_task
    else
        show_query_options
    end
end

def query_by_index(int)
    case int
    when 0
        clear_screen
        ask_task
    when 1
        puts "Please enter the name of the specified character"
        buffer
        r = gets.chomp
        ans = character_equipment_value?(r)
        puts "#{r}'s total equipment value is #{ans}"
    when 2
        puts "Please enter the name of the specified character"
        buffer
        r = gets.chomp
        ans = character_num_items(r)
        puts "#{r}'s item total is #{ans} item(s)"
    when 3
        puts "Please enter the name of the specified character"
        buffer
        r = gets.chomp
        ans = character_equipment_weight(r)
        puts "#{r}'s total inventory weight is #{ans}"
    when 4
        char = Character.most_items
        puts "The character with the most items (Equipment) is #{char.name}"
    when 5
        char = Character.fewest_items 
        puts "The character with the fewest items (Equipment) is #{char.name}"
    when 6
        char = Character.most_encumbered
        puts "The character with the most inventory weight is #{char.name}"
    when 7
        puts "Please enter the name of the specified item"
        buffer
        r = gets.chomp
        ans = how_many_characters_own?(r)
        puts "#{ans} characters own a(n) #{r}"
    when 8
        #Show how many instances of a specified item exist
        puts "Please enter the name of the specified item"
        buffer
        r = gets.chomp
        ans = Equipment.find_by(name: r).how_many_exist?
        puts "#{r} has been purchased #{ans} time(s)"
    when 9
        #Which item is owned by the most characters?
        item = Equipment.most_owned_item
        num_characters = how_many_characters_own?(item.name)
        puts "#{item.name} is the most owned item with #{num_characters} owners"
    when 10
        item = Equipment.most_popular_weapon
        puts "#{item.name} is the most popular weapon"
    end
end

def character_equipment_value?(character_name)
    Character.find_by(name: character_name).total_value_of_items
end

def character_num_items(character_name)
    Character.find_by(name: character_name).total_items
end

def character_equipment_weight(character_name)
    Character.find_by(name: character_name).character_weight
end

def how_many_characters_own?(item_name)
    Equipment.find_by(name: item_name).how_many_own
end