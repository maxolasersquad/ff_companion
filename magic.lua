local memory_start = 0x30150

local magics = {
    [0x00] = "Cure",
    [0x01] = "Harm",
    [0x02] = "Fog",
    [0x03] = "Ruse",
    [0x04] = "Fire",
    [0x05] = "Sleep",
    [0x06] = "Lock",
    [0x07] = "Lightning",
    [0x08] = "Lamp",
    [0x09] = "Mute",
    [0x0A] = "Anti-Lightning",
    [0x0B] = "Invisible",
    [0x0C] = "Ice",
    [0x0D] = "Dark",
    [0x0E] = "Tmpr",
    [0x0F] = "Slow",
    [0x10] = "Cure 2",
    [0x11] = "Harm 2",
    [0x12] = "Anti-Fire",
    [0x13] = "Heal",
    [0x14] = "Fire 2",
    [0x15] = "Hold",
    [0x16] = "Lightning 2",
    [0x17] = "Lock 2",
    [0x18] = "Pure",
    [0x19] = "Fear",
    [0x1A] = "Anti-Ice",
    [0x1B] = "Anti-Mute",
    [0x1C] = "Sleep 2",
    [0x1D] = "Fast",
    [0x1E] = "Confusion",
    [0x1F] = "Ice 2",
    [0x20] = "Cure 3",
    [0x21] = "Life",
    [0x22] = "Harm 3",
    [0x23] = "Heal 2",
    [0x24] = "Fire 3",
    [0x25] = "Bane",
    [0x26] = "Warp",
    [0x27] = "Slow 2",
    [0x28] = "Soft",
    [0x29] = "Exit",
    [0x2A] = "Fog 2",
    [0x2B] = "Invisible 2",
    [0x2C] = "Lightning 3",
    [0x2D] = "Rub",
    [0x2E] = "Quake",
    [0x2F] = "Stun",
    [0x30] = "Cure 4",
    [0x31] = "Harm 4",
    [0x32] = "Anti-Rub",
    [0x33] = "Heal 3",
    [0x34] = "Ice 3",
    [0x35] = "Break",
    [0x36] = "Saber",
    [0x37] = "Blind",
    [0x38] = "Life 2",
    [0x39] = "Fade",
    [0x3A] = "Wall",
    [0x3B] = "Transfer",
    [0x3C] = "Nuke",
    [0x3D] = "Stop",
    [0x3E] = "Zap!",
    [0x3F] = "XXXX",
}

local properties = {
    unknown        = 0x00,
    effectivity    = 0x01,
    elemental      = 0x02,
    targetting     = 0x03,
    effect         = 0x04,
    graphics_block = 0x05,
    palette        = 0x06,
}

local Magic = {
    ramLocation = nil,
}

function Magic:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Magic:getValueByLocationOffset(offset)
    return rom.readbyte(memory_start + (self.ramLocation - 1) * 7 + offset)
end

function Magic:getUnknown ()
    return self:getValueByLocationOffset(properties['unknown'])
end

function Magic:getEffectivity ()
    return self:getValueByLocationOffset(properties['effectivity'])
end

function Magic:getElemental ()
    return self:getValueByLocationOffset(properties['elemental'])
end

function Magic:getTargetting ()
    return self:getValueByLocationOffset(properties['targetting'])
end

function Magic:getEffect ()
    return self:getValueByLocationOffset(properties['effect'])
end

function Magic:getGraphicsBlock ()
    return self:getValueByLocationOffset(properties['graphics_block'])
end

function Magic:getPalette ()
    return self:getValueByLocationOffset(properties['palette'])
end

return Magic
