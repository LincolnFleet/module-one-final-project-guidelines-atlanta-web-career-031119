require_relative '../config/environment'
require_relative '../app/cli_elements/cli_main.rb'
require_relative '../app/cli_elements/dice.rb'

greeting

## CHAR
name=get_name
level=get_level
char_class=get_class
race=get_race
money=get_money
char_instance(name, level, char_class, race, money)

## STATS


## INVENTORY


binding.pry
