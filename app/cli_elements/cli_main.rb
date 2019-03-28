require_relative './dice.rb'
require 'pry'
require 'tty-table'

def run_program
    greeting
    ask_task
end
def greeting
    puts "      Hello and welcome to the character library!"
end

def ask_task
    puts "\n\n      If you would like to create a new character enter 'create'\n
      If you would like ask a question about existing characters and/or items enter 'question'\n
      To exit the character library, enter 'quit'\n\n"
    response = gets.chomp
    if response == "create"
        get_info
    elsif response == "question"
        #question_method
    else
        ask_task
    end
end 

def get_name
    puts "      Here we will begin the character creation process"
    puts "      What is your character's name?"
end

def sleeps
    puts "      ."
    sleep(1)
end

def get_info
    get_name
    name = gets.chomp
    get_class
    char_class = gets.chomp
    get_race
    race = gets.chomp
    money = get_money(char_class)
    puts "Your starting money is determined by your class choice.\n
        This character will be starting with #{money} copper pieces."
    character = char_instantiate(name, 1, char_class, race, money)
    assign_stats(character)
    puts "      Your stats are being rolled!"
    sleeps
    sleeps
    sleeps
    sleeps
    sleeps
    show_stats(character)
end

def get_class
    puts "What is your character's class?"
end

def get_race
    puts "What is your character's race?"
end

def get_money(char_class)
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
    else 
        4.times {|x| wallet += roll_d4}
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
    char_stats = CharacterAttribute.find_by(character_id: character.id)
    puts "#{character.name}'s ability scores are:\n"
    puts "Strength:      #{char_stats.strength}"
    puts "Dexterity:     #{char_stats.dexterity}"
    puts "Constitution:  #{char_stats.constitution}"
    puts "Intelligence:  #{char_stats.intelligence}"
    puts "Wisdom:        #{char_stats.wisdom}"
    puts "Charisma:      #{char_stats.charisma}"
    puts "Hit Points:    #{char_stats.max_hitpoints}"
    puts "Experience:    #{char_stats.experience_points}"
    puts
end

######################################
#EQUIP


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
    Inventory.create(char.id, equip.id)
end

def can_buy?(equip, char)
    char.money >= equip.cost
end