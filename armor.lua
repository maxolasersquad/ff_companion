local Armor = {
    absoluteAddress = 0x30150,
    segmentAddress = nil,
    propertyOffsets = {
        evasion        = 0x00,
        absorption     = 0x01,
        special_effect = 0x02,
        magic          = 0x03,
    },
    names = {
        [0x00] = "",
        [0x01] = "Cloth",
        [0x02] = "Wooden Armor",
        [0x03] = "Chain Armor",
        [0x04] = "Iron Armor",
        [0x05] = "Steel Armor",
        [0x06] = "Silver Armor",
        [0x07] = "Flame Armor",
        [0x08] = "Ice Armor",
        [0x09] = "Opal Armor",
        [0x0A] = "Dragon Armor",
        [0x0B] = "Copper Bracelet",
        [0x0C] = "Silver Bracelet",
        [0x0D] = "Gold Bracelet",
        [0x0E] = "Opal Bracelet",
        [0x0F] = "White Shirt",
        [0x10] = "Black Shirt",
        [0x11] = "Wooden Shield",
        [0x12] = "Iron Shield",
        [0x13] = "Silver Shield",
        [0x14] = "Flame Shield",
        [0x15] = "Ice Shield",
        [0x16] = "Opal Shield",
        [0x17] = "Aegis",
        [0x18] = "Buckler",
        [0x19] = "Procape",
        [0x1A] = "Cape",
        [0x1B] = "Wooden Helmet",
        [0x1C] = "Iron Helmet",
        [0x1D] = "Silver Helmet",
        [0x1E] = "Opal Helmet",
        [0x1F] = "Heal Helmet",
        [0x20] = "Ribbon",
        [0x21] = "Gloves",
        [0x22] = "Copper Gauntlet",
        [0x23] = "Iron Gauntlet",
        [0x24] = "Silver Gauntlet",
        [0x25] = "Zeus Gauntlet",
        [0x26] = "Power Gauntlet",
        [0x27] = "Opal Gauntlet",
        [0x28] = "Proring"
    },
    effects = {
        [0x00] = "None",
        [0x02] = "Protection from stun.",
        [0x08] = "Protection from rub.",
        [0x10] = "Protection from ice.",
        [0x18] = "Unknown",
        [0x20] = "Protection from fire.",
        [0x24] = "Unknown",
        [0x40] = "Protection from lightning.",
        [0x70] = "Protection from dragons.",
        [0xFF] = "Protection from instant death.",
    },
}

function Armor:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Armor:getValueByLocationOffset(offset)
    return rom.readbyte(Armor.absoluteAddress + (self.segmentAddress - 1) * 4 + offset)
end

function Armor:getName ()
    return Armor.names[self.segmentAddress]
end

function Armor:getEvasion ()
    return self:getValueByLocationOffset(Armor.propertyOffsets['evasion'])
end

function Armor:getAbsorption ()
    return self:getValueByLocationOffset(Armor.propertyOffsets['absorption'])
end

function Armor:getSpecialEffect ()
    return Armor.effects[self:getValueByLocationOffset(Armor.propertyOffsets['special_effect'])]
end

function Armor:getMagic ()
    return self:getValueByLocationOffset(Armor.propertyOffsets['magic'])
end

return Armor
