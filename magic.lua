local Magic = {
    absoluteAddress = 0x30150,
    segmentAddress = nil,
    propertyOffsets = {
        unknown        = 0x00,
        effectivity    = 0x01,
        elemental      = 0x02,
        targetting     = 0x03,
        effect         = 0x04,
        graphics_block = 0x05,
        palette        = 0x06,
    },
    names = {
        [0x00] = "",
        [0x01] = "Cure",
        [0x02] = "Harm",
        [0x03] = "Fog",
        [0x04] = "Ruse",
        [0x05] = "Fire",
        [0x06] = "Sleep",
        [0x07] = "Lock",
        [0x08] = "Lightning",
        [0x09] = "Lamp",
        [0x0A] = "Mute",
        [0x0B] = "Anti-Lightning",
        [0x0C] = "Invisible",
        [0x0D] = "Ice",
        [0x0E] = "Dark",
        [0x0F] = "Tmpr",
        [0x10] = "Slow",
        [0x11] = "Cure 2",
        [0x12] = "Harm 2",
        [0x13] = "Anti-Fire",
        [0x14] = "Heal",
        [0x15] = "Fire 2",
        [0x16] = "Hold",
        [0x17] = "Lightning 2",
        [0x18] = "Lock 2",
        [0x19] = "Pure",
        [0x1A] = "Fear",
        [0x1B] = "Anti-Ice",
        [0x1C] = "Anti-Mute",
        [0x1D] = "Sleep 2",
        [0x1E] = "Fast",
        [0x1F] = "Confusion",
        [0x20] = "Ice 2",
        [0x21] = "Cure 3",
        [0x22] = "Life",
        [0x23] = "Harm 3",
        [0x24] = "Heal 2",
        [0x25] = "Fire 3",
        [0x26] = "Bane",
        [0x27] = "Warp",
        [0x28] = "Slow 2",
        [0x29] = "Soft",
        [0x2A] = "Exit",
        [0x2B] = "Fog 2",
        [0x2C] = "Invisible 2",
        [0x2D] = "Lightning 3",
        [0x2E] = "Rub",
        [0x2F] = "Quake",
        [0x30] = "Stun",
        [0x31] = "Cure 4",
        [0x32] = "Harm 4",
        [0x33] = "Anti-Rub",
        [0x34] = "Heal 3",
        [0x35] = "Ice 3",
        [0x36] = "Break",
        [0x37] = "Saber",
        [0x38] = "Blind",
        [0x39] = "Life 2",
        [0x3A] = "Fade",
        [0x3B] = "Wall",
        [0x3C] = "Transfer",
        [0x3D] = "Nuke",
        [0x3E] = "Stop",
        [0x3F] = "Zap!",
        [0x40] = "XXXX",
    },
}

function Magic:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Magic:getValueByLocationOffset(offset)
    return rom.readbyte(Magic.absoluteAddress + (self.segmentAddress - 1) * 7 + offset)
end

function Magic:getName ()
    return Magic.names[self.segmentAddress]
end

function Magic:getUnknown ()
    return self:getValueByLocationOffset(Magic.propertyOffsets['unknown'])
end

function Magic:getEffectivity ()
    return self:getValueByLocationOffset(Magic.propertyOffsets['effectivity'])
end

function Magic:getElemental ()
    return self:getValueByLocationOffset(Magic.propertyOffsets['elemental'])
end

function Magic:getTargetting ()
    return self:getValueByLocationOffset(Magic.propertyOffsets['targetting'])
end

function Magic:getEffect ()
    return self:getValueByLocationOffset(Magic.propertyOffsets['effect'])
end

function Magic:getGraphicsBlock ()
    return self:getValueByLocationOffset(Magic.propertyOffsets['graphics_block'])
end

function Magic:getPalette ()
    return self:getValueByLocationOffset(Magic.propertyOffsets['palette'])
end

return Magic
