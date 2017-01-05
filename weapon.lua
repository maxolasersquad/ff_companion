local Weapon = {
    absoluteAddress = 0x30010,
    segmentAddress = nil,
    propertyOffsets = {
        hit_percentage = 0x00,
        damage         = 0x01,
        unknown        = 0x02, -- The purpose of this memory location is unknown
        spell_cast     = 0x03,
        element        = 0x04,
        special_effect = 0x05,
        graphics_block = 0x06,
        palette        = 0x07,
    },
    names = {
        [0x00] = "",
        [0x01] = "Wooden Nunchuck",
        [0x02] = "Small Knife",
        [0x03] = "Wooden Staff",
        [0x04] = "Rapier",
        [0x05] = "Iron Hammer",
        [0x06] = "Short Sword",
        [0x07] = "Hand Axe",
        [0x08] = "Scimtar",
        [0x09] = "Iron Nunchuck",
        [0x0a] = "Large Knife",
        [0x0b] = "Iron Staff",
        [0x0c] = "Sabre",
        [0x0d] = "Long Sword",
        [0x0e] = "Great Axe",
        [0x0f] = "Falchon",
        [0x10] = "Silver Knife",
        [0x11] = "Silver Sword",
        [0x12] = "Silver Hammer",
        [0x13] = "Silver Axe",
        [0x14] = "Flame Sword",
        [0x15] = "Ice Sword",
        [0x16] = "Dragon Sword",
        [0x17] = "Giant Sword",
        [0x18] = "Sun Sword",
        [0x19] = "Corel Sword",
        [0x1a] = "Were Sword",
        [0x1b] = "Rune Sword",
        [0x1c] = "Power Staff",
        [0x1d] = "Light Axe",
        [0x1e] = "Heal Staff",
        [0x1f] = "Mage Staff",
        [0x20] = "Defense",
        [0x21] = "Wizard Staff",
        [0x22] = "Vorpal",
        [0x23] = "Catclaw",
        [0x24] = "Thor Hammer",
        [0x25] = "Bane Sword",
        [0x26] = "Katana",
        [0x27] = "Xcaliber",
        [0x28] = "Masamune",
    },
    elementals = {
        [0x00] = "None",
        [0x10] = "Fire",
        [0x20] = "Ice",
        [0xFF] = "All",
    },
    effects = {
        [0x00] = "No effect",
        [0x02] = "Increased damage against dragons.",
        [0x04] = "Increased damage against giants.",
        [0x08] = "Increased damage against undead.",
        [0x10] = "Increased damage against were foes.",
        [0x20] = "Increased damage against water foes.",
        [0x40] = "Increased damage against magicians.",
        [0x88] = "?",
        [0xFF] = "Increased damage against all.",
    },
}

function Weapon:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Weapon:getValueByLocationOffset(offset)
    return rom.readbyte(self.absoluteAddress + self.segmentAddress * 6 + offset)
end

function Weapon:getName ()
    return Weapon.names[self.segmentAddress]
end

function Weapon:getHitPercentage ()
    return self:getValueByLocationOffset(Weapon.propertyOffsets['hit_percentage'])
end

function Weapon:getDamage ()
    return self:getValueByLocationOffset(Weapon.propertyOffsets['damage'])
end

function Weapon:getUnknown ()
    return self:getValueByLocationOffset(Weapon.propertyOffsets['unknown'])
end

function Weapon:getSpellCast ()
    return self:getValueByLocationOffset(Weapon.propertyOffsets['spell_cast'])
end

function Weapon:getElement ()
    return Weapon.elementals[self:getValueByLocationOffset(Weapon.propertyOffsets['element'])]
end

function Weapon:getSpecialEffect ()
    return Weapon.effects[self:getValueByLocationOffset(Weapon.propertyOffsets['special_effect'])]
end

function Weapon:getGraphicsBlock ()
    return self:getValueByLocationOffset(Weapon.propertyOffsets['graphics_block'])
end

function Weapon:getPalette ()
    return self:getValueByLocationOffset(Weapon.propertyOffsets['palette'])
end

return Weapon
