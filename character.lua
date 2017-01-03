charmap = require 'charmap'
bit = require 'bit32'

local character = {
    character1       = 0x6100,
    character2       = 0x6140,
    character3       = 0x6180,
    character4       = 0x61C0,
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
    max_damage       = 0x20,
    hit_percent      = 0x21,
    absorb_level     = 0x22,
    evasion          = 0x23,
    hit_percent_2    = 0x25,
    level            = 0x26,
}

local Character = {
    ramLocation = nil,
    name = nil,
    status = nil,
    xp = nil,
    hp = nil,
    maxHp = nil,
    strength = nil,
}

function Character:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Character:getValueByLocationOffset(offset)
  return memory.readbyte(self.ramLocation + offset)
end

function Character:getValueByHighbyteAndLowbyteOffset(highbyte_offset, lowbyte_offset)
  return bit.lshift(memory.readbyte(self.ramLocation + highbyte_offset), 8) + memory.readbyte(self.ramLocation + lowbyte_offset)
end

function Character:getName ()
    return charmap[self:getValueByLocationOffset(character['name1'])] .. charmap[self:getValueByLocationOffset(character['name2'])] .. charmap[self:getValueByLocationOffset(character['name3'])] .. charmap[self:getValueByLocationOffset(character['name4'])]
end

function Character:getStatus()
    return self:getValueByLocationOffset(character['status'])
end

function Character:getExperience()
    return self:getValueByHighbyteAndLowbyteOffset(character['xp_highbyte'], character['xp_lowbyte'])
end

function Character:getHP()
    return self:getValueByHighbyteAndLowbyteOffset(character['hp_highbyte'], character['hp_lowbyte'])
end

function Character:getMaxHP()
    return self:getValueByHighbyteAndLowbyteOffset(character['max_hp_highbyte'], character['max_hp_lowbyte'])
end

local character1 = Character:new{ramLocation = character['character1']}
local character2 = Character:new{ramLocation = character['character2']}

return {
    character1 = character1,
    character2 = character2,
}
