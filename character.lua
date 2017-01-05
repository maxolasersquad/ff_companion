charmap = require 'charmap'
bit = require 'bit32'
Armor = require 'armor'
Weapon = require 'weapon'

local Character = {
    absoluteAddress = nil,
    absoluteAddresses = {
      0x6100,
      0x6140,
      0x6180,
      0x61C0,
    },
    propertyOffsets = {
        status           = 0x01,
        name1            = 0x02,
        name2            = 0x03,
        name3            = 0x04,
        name4            = 0x05,
        xp_lowbyte       = 0x07,
        xp_highbyte      = 0x08,
        hp_lowbyte       = 0x0A,
        hp_highbyte      = 0x0B,
        max_hp_lowbyte   = 0x0C,
        max_hp_highbyte  = 0x0D,
        strength         = 0x10,
        agility          = 0x11,
        intelligence     = 0x12,
        vitality         = 0x13,
        luck             = 0x14,
        next_xp_lowbyte  = 0x16,
        next_xp_highbyte = 0x17,
        weapon_1         = 0x18,
        weapon_2         = 0x19,
        weapon_3         = 0x1A,
        weapon_4         = 0x1B,
        armor_1          = 0x1C,
        armor_2          = 0x1D,
        armor_3          = 0x1E,
        armor_4          = 0x1F,
        damage           = 0x20,
        hit_percent      = 0x21,
        absorb           = 0x22,
        evade_percent    = 0x23,
        hit_percent_2    = 0x25,
        level            = 0x26,
    },
}

function Character:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Character:getValueByLocationOffset(offset)
    return memory.readbyte(self.absoluteAddress + offset)
end

function Character:getValueByHighbyteAndLowbyteOffset(highbyte_offset, lowbyte_offset)
    return bit.lshift(memory.readbyte(self.absoluteAddress + highbyte_offset), 8) + memory.readbyte(self.absoluteAddress + lowbyte_offset)
end

function Character:getName ()
    return charmap[self:getValueByLocationOffset(Character.propertyOffsets['name1'])] .. charmap[self:getValueByLocationOffset(Character.propertyOffsets['name2'])] .. charmap[self:getValueByLocationOffset(Character.propertyOffsets['name3'])] .. charmap[self:getValueByLocationOffset(Character.propertyOffsets['name4'])]
end

function Character:getStatus()
    return self:getValueByLocationOffset(Character.propertyOffsets['status'])
end

function Character:getExperience()
    return self:getValueByHighbyteAndLowbyteOffset(Character.propertyOffsets['xp_highbyte'], Character.propertyOffsets['xp_lowbyte'])
end

function Character:getHP()
    return self:getValueByHighbyteAndLowbyteOffset(Character.propertyOffsets['hp_highbyte'], Character.propertyOffsets['hp_lowbyte'])
end

function Character:getMaxHP()
    return self:getValueByHighbyteAndLowbyteOffset(Character.propertyOffsets['max_hp_highbyte'], Character.propertyOffsets['max_hp_lowbyte'])
end

function Character:getStrength()
    return self:getValueByLocationOffset(Character.propertyOffsets['strength'])
end

function Character:getAgility()
    return self:getValueByLocationOffset(Character.propertyOffsets['agility'])
end

function Character:getIntelligence()
    return self:getValueByLocationOffset(Character.propertyOffsets['intelligence'])
end

function Character:getVitality()
    return self:getValueByLocationOffset(Character.propertyOffsets['vitality'])
end

function Character:getLuck()
    return self:getValueByLocationOffset(Character.propertyOffsets['luck'])
end

function Character:getNextXP()
    return self:getValueByHighbyteAndLowbyteOffset(Character.propertyOffsets['next_xp_highbyte'], Character.propertyOffsets['next_xp_lowbyte'])
end

function Character:getWeapon(weapon_number)
    return Weapon:new{segmentAddress = self:getValueByLocationOffset(Character.propertyOffsets['weapon_' .. weapon_number])}
end

function Character:getArmor(armor_number)
    return Armor:new{segmentAddress = self:getValueByLocationOffset(Character.propertyOffsets['armor_' .. armor_number])}
end

function Character:getDamage()
    return self:getValueByLocationOffset(Character.propertyOffsets['damage'])
end

function Character:getHitPercent()
    return self:getValueByLocationOffset(Character.propertyOffsets['hit_percent'])
end

function Character:getAbsorb()
    return self:getValueByLocationOffset(Character.propertyOffsets['absorb'])
end

function Character:getEvadePercent()
    return self:getValueByLocationOffset(Character.propertyOffsets['evade_percent'])
end

function Character:getHitPercent2()
    return self:getValueByLocationOffset(Character.propertyOffsets['hit_percent_2'])
end

function Character:getLevel()
    return self:getValueByLocationOffset(Character.propertyOffsets['level']) + 1
end

local character1 = Character:new{absoluteAddress = Character.absoluteAddresses[1]}
local character2 = Character:new{absoluteAddress = Character.absoluteAddresses[2]}
local character3 = Character:new{absoluteAddress = Character.absoluteAddresses[3]}
local character4 = Character:new{absoluteAddress = Character.absoluteAddresses[4]}

return {
    character1,
    character2,
    character3,
    character4,
}
