require 'pry'
require_relative './dice.rb'
def greeting
    puts "Hello and welcome to the character creator!"
end

# def ask_task
#     prompt=TTY::Prompt.new
#     prompt.ask('do you want to search for a character or create a new one?')
# end

def get_name
    prompt=TTY::Prompt.new
    prompt.ask("What is your character's name?") 
end

# def get_level
#     prompt=TTY::Prompt.new
#     prompt.ask("What is your character's starting level? (choose a number between 1 and 20)")
# end

def get_class
    prompt=TTY::Prompt.new
    prompt.ask("What is your character's class?")
end

def get_race
    prompt=TTY::Prompt.new
    prompt.ask("What is your character's race?")
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

def char_instance(n, l=1, c_c=nil, r=nil)
    Character.create(name: n, level: l, char_class: c_c, race: r)
end

######################################
#STATS

def gen_hitpoints(char_class, constitution)
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
    hitpoints + constitution
end
binding.pry

# # when "warlock"
#     :charisma=array[0]
#     :wisdom=array[1]
# # when "wizard"
#     :charisma=[3]
#     :wido

def roll_stats
    array=[]
    12.times do |x|
        array<<roll_d20
    end
    array.!sort
    array.pop(3)
end