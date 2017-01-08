charmap = require 'charmap'
bit = require 'bit32'
Armor = require 'armor'
Magic = require 'magic'
Weapon = require 'weapon'

local CharacterMagic = {
    absoluteAddress = nil,
    absoluteAddresses = {
        0x6300,
        0x6330,
        0x6360,
        0x6390,
    },
    propertyOffsets = {
        level_1_slot_1 = 0x00,
        level_1_slot_2 = 0x01,
        level_1_slot_3 = 0x02,
        level_2_slot_1 = 0x04,
        level_2_slot_2 = 0x05,
        level_2_slot_3 = 0x06,
        level_3_slot_1 = 0x08,
        level_3_slot_2 = 0x09,
        level_3_slot_3 = 0x0A,
        level_4_slot_1 = 0x0C,
        level_4_slot_2 = 0x0D,
        level_4_slot_3 = 0x0E,
        level_5_slot_1 = 0x10,
        level_5_slot_2 = 0x11,
        level_5_slot_3 = 0x12,
        level_6_slot_1 = 0x14,
        level_6_slot_2 = 0x15,
        level_6_slot_3 = 0x16,
        level_7_slot_1 = 0x18,
        level_7_slot_2 = 0x19,
        level_7_slot_3 = 0x1A,
        level_8_slot_1 = 0x1C,
        level_8_slot_2 = 0x1D,
        level_8_slot_3 = 0x1E,
        magic_level_1_max_mp = 0x20,
        magic_level_2_max_mp = 0x21,
        magic_level_3_max_mp = 0x22,
        magic_level_4_max_mp = 0x23,
        magic_level_5_max_mp = 0x24,
        magic_level_6_max_mp = 0x25,
        magic_level_7_max_mp = 0x26,
        magic_level_8_max_mp = 0x27,
        magic_level_1_mp     = 0x28,
        magic_level_2_mp     = 0x29,
        magic_level_3_mp     = 0x2A,
        magic_level_4_mp     = 0x2B,
        magic_level_5_mp     = 0x2C,
        magic_level_6_mp     = 0x2D,
        magic_level_7_mp     = 0x2E,
        magic_level_8_mp     = 0x2F,
    }
}

function CharacterMagic:new (o)
    setmetatable(o, self)
    self.__index = self
    return o
end

function CharacterMagic:getValueByLocationOffset(offset)
    return memory.readbyte(self.absoluteAddress + offset)
end

function CharacterMagic:getMagic(level, slot)
    return Magic:new{segmentAddress = self:getValueByLocationOffset(CharacterMagic.propertyOffsets['level_' .. level .. '_slot_' .. slot])}
end

function CharacterMagic:getMagicPoints(level)
    return self:getValueByLocationOffset(CharacterMagic.propertyOffsets['magic_level_' .. level .. '_mp'])
end

function CharacterMagic:getMaxMagicPoints(level)
    return self:getValueByLocationOffset(CharacterMagic.propertyOffsets['magic_level_' .. level .. '_max_mp'])
end

local Character = {
    absoluteAddress = nil,
    absoluteAddresses = {
        0x6100,
        0x6140,
        0x6180,
        0x61C0,
    },
    characterNumber = nil,
    magics = nil,
    propertyOffsets = {
        order            = 0x00,
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
    o.absoluteAddress = self.absoluteAddresses[o.characterNumber]
    o.magics = CharacterMagic:new{absoluteAddress = CharacterMagic.absoluteAddresses[o.characterNumber]}
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

function Character:getOrder()
    return self:getValueByLocationOffset(Character.propertyOffsets['order'])
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
    weapon_address = self:getValueByLocationOffset(Character.propertyOffsets['weapon_' .. weapon_number])
    -- The high byte indicates if the weapon is equipped, the low byte is the offset.
    value = weapon_address % 0x10
    return Weapon:new{segmentAddress = value}
end

function Character:getEquippedWeaponIndex()
    for i = 1,4 do
        weapon_value = self:getValueByLocationOffset(Character.propertyOffsets['weapon_' .. i])
        -- If the high byte is 08 then this weapon is equipped
        if bit.rshift(weapon_value, 4) == 0x08 then
            return i
        end
    end
end

function Character:getArmor(armor_number)
    armor_address = self:getValueByLocationOffset(Character.propertyOffsets['armor_' .. armor_number])
    -- If the high byte is 08 then this armor is equipped
    value = armor_address % 0x10
    return Armor:new{segmentAddress = value}
end

function Character:getEquippedArmorIndex()
    for i = 1,4 do
        armor_value = self:getValueByLocationOffset(Character.propertyOffsets['armor_' .. i])
        -- If the high byte is 08 then this armor is equipped
        if bit.rshift(armor_value, 4) == 0x08 then
            return i
        end
    end
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

function Character:getMagic(level, slot)
    return self.magics:getMagic(level, slot)
end

function Character:getMagicPoints(level)
    return self.magics:getMagicPoints(level)
end

function Character:getMaxMagicPoints(level)
    return self.magics:getMaxMagicPoints(level)
end

function Character:getHexMap()
    map = ''
    i = 0
    while i < 64 do
      value = string.format('%02x', memory.readbyte(self.absoluteAddress + i))
      if value == nil then
          map = map .. '_'
      else
          map = map .. value .. ' '
      end
      i = i + 1
    end
    return map
end

local character1 = Character:new{characterNumber = 1}
local character2 = Character:new{characterNumber = 2}
local character3 = Character:new{characterNumber = 3}
local character4 = Character:new{characterNumber = 4}

return {
    character1,
    character2,
    character3,
    character4,
}
