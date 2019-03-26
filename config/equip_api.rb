require 'pry'
require 'rest-client'
require 'json'

def get_api_equip
    all_equip = RestClient.get('http://www.dnd5eapi.co/api/equipment/')
    all_equip_hash = JSON.parse(all_equip)
    all_equip_hash["results"]
end

def inner_url(hash)
    info_string = RestClient.get("#{hash["url"]}")
    info_hash = JSON.parse(info_string)
    info_hash
end

def get_name(hash)
    hash["name"]
end

def get_category(hash)
    inner_url(hash)["equipment_category"]
end

def get_cost(hash)
    q = inner_url(hash)["cost"]["quantity"]
    t = inner_url(hash)["cost"]["unit"]
    convert_currency_to_copper(q, t)
end

def get_weight(hash)
    inner_url(hash)["weight"]
end

def convert_currency_to_copper(quantity, unit)
    total_cp = 0
    if unit == "cp"
        total_cp = quantity
    elsif unit == "sp"
        total_cp = quantity * 10
    elsif unit == "ep"
        total_cp = quantity * 50
    elsif unit == "gp"
        total_cp = quantity * 100
    elsif unit == "pp"
        total_cp = quantity * 1000
    end
    total_cp
end

def seed_equip_table 
    get_api_equip.each do |item|
        var_name = get_name(item)
        var_category = get_category(item)
        var_cost = get_cost(item)
        var_weight = get_weight(item)

        Equipment.create(name: var_name, equipment_category: var_category, cost: var_cost, weight: var_weight)
    end
end
