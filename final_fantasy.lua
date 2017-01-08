-- Most of the technical information provided by http://datacrystal.romhacking.net/wiki/Final_Fantasy:RAM_map

bit = require 'bit32'
lgi = require 'lgi'
character = require 'character'

Gtk = lgi.require('Gtk', '3.0')
builder = Gtk.Builder()
builder:add_from_file('main.glade')
window = builder:get_object('window')

local handlers = {}

function handlers.destroy(window)
    os.exit()
end
builder:connect_signals(handlers)

CharacterStats = {
    characterNumber = nil,
    properties = {
        'name',
        'class',
        'level',
        'hp',
        'max_hp',
        'experience',
        'next_level',
        'strength',
        'agility',
        'intelligence',
        'vitality',
        'luck',
        'damage',
        'hit_percent',
        'absorb',
        'evade_percent',
        'magic_level_1_slot_1',
        'magic_level_1_slot_2',
        'magic_level_1_slot_3',
        'magic_level_1_slot_4',
        'magic_level_2_slot_1',
        'magic_level_2_slot_2',
        'magic_level_2_slot_3',
        'magic_level_2_slot_4',
        'magic_level_3_slot_1',
        'magic_level_3_slot_2',
        'magic_level_3_slot_3',
        'magic_level_3_slot_4',
        'magic_level_4_slot_1',
        'magic_level_4_slot_2',
        'magic_level_4_slot_3',
        'magic_level_4_slot_4',
        'magic_level_5_slot_1',
        'magic_level_5_slot_2',
        'magic_level_5_slot_3',
        'magic_level_5_slot_4',
        'magic_level_6_slot_1',
        'magic_level_6_slot_2',
        'magic_level_6_slot_3',
        'magic_level_6_slot_4',
        'magic_level_7_slot_1',
        'magic_level_7_slot_2',
        'magic_level_7_slot_3',
        'magic_level_7_slot_4',
        'magic_level_8_slot_1',
        'magic_level_8_slot_2',
        'magic_level_8_slot_3',
        'magic_level_8_slot_4',
        'magic_points_level_1',
        'magic_points_level_2',
        'magic_points_level_3',
        'magic_points_level_4',
        'magic_points_level_5',
        'magic_points_level_6',
        'magic_points_level_7',
        'magic_points_level_8',
        'max_magic_points_level_1',
        'max_magic_points_level_2',
        'max_magic_points_level_3',
        'max_magic_points_level_4',
        'max_magic_points_level_5',
        'max_magic_points_level_6',
        'max_magic_points_level_7',
        'max_magic_points_level_8',
        'weapon_slot_1',
        'weapon_slot_2',
        'weapon_slot_3',
        'weapon_slot_4',
        'armor_slot_1',
        'armor_slot_2',
        'armor_slot_3',
        'armor_slot_4',
    }
}

function CharacterStats:new (o)
    setmetatable(o, self)
    self.__index = self
    o:init()
    return o
end

function CharacterStats:getPropertyName(property)
    return 'character_' .. self.characterNumber .. '_' .. property
end

function CharacterStats:init()
    for i in pairs(self.properties) do
        property = self.properties[i]
        self[property] = builder:get_object(self:getPropertyName(property))
    end
end

characterStats = {
    CharacterStats:new{characterNumber = 1},
    CharacterStats:new{characterNumber = 2},
    CharacterStats:new{characterNumber = 3},
    CharacterStats:new{characterNumber = 4},
}

window:show_all()

gameRam = {
    buttonPressed = 0x0020,
    displayMode   = 0x000D,
}

controller = {
    right = 0x01,
    left = 0x02,
    down = 0x04,
    up = 0x08,
    start = 0x10,
    sel = 0x20,
    a = 0x40,
    b = 0x80
}

controllerBits = {
    right = 0,
    left = 1,
    down = 2,
    up = 3,
    start = 4,
    sel = 5,
    b = 6,
    a = 7
}

function getButtonPressed()
    return memory.readbyte(gameRam['buttonPressed'])
end

function updateButtonPressed()
    buttonPressed:set_text(getButtonPressed(), -1)
end

function updateRightButton()
    pressed = isButtonPressed(controllerBits['right'])
    buttonRight:set_text(tostring(pressed), -1)
end

function updateLeftButton()
    pressed = isButtonPressed(controllerBits['left'])
    buttonLeft:set_text(tostring(pressed), -1)
end

function updateDownButton()
    pressed = isButtonPressed(controllerBits['down'])
    buttonDown:set_text(tostring(pressed), -1)
end

function updateUpButton()
    pressed = isButtonPressed(controllerBits['up'])
    buttonUp:set_text(tostring(pressed), -1)
end

function updateStartButton()
    pressed = isButtonPressed(controllerBits['start'])
    buttonStart:set_text(tostring(pressed), -1)
end

function updateSelectButton()
    pressed = isButtonPressed(controllerBits['sel'])
    buttonSelect:set_text(tostring(pressed), -1)
end

function updateBButton()
    pressed = isButtonPressed(controllerBits['b'])
    buttonB:set_text(tostring(pressed), -1)
end

function updateAButton()
    pressed = isButtonPressed(controllerBits['a'])
    buttonA:set_text(tostring(pressed), -1)
end

function getMaskBit(mask, bitNumber)
    return bit.band(mask, (bit.lshift(1, bitNumber))) ~= 0
end

function isButtonPressed(button)
    return getMaskBit(getButtonPressed(), button)
end

function updateDisplayMode()
    mode = memory.readbyte(gameRam['displayMode'])
    displayMode:set_text(mode, -1)
end

function updateCharacterName(character_index)
    characterStats[character_index].name:set_text(character[character_index]:getName(), -1)
end

function updateCharacterLevel(character_index)
    characterStats[character_index].level:set_text("Level: " .. character[character_index]:getLevel(), -1)
end

function updateCharacterHP(character_index)
    characterStats[character_index].hp:set_text(character[character_index]:getHP(), -1)
end

function updateCharacterMaxHP(character_index)
    characterStats[character_index].max_hp:set_text(character[character_index]:getMaxHP(), -1)
end

function updateCharacterExperience(character_index)
    characterStats[character_index].experience:set_text(character[character_index]:getExperience(), -1)
end

function updateCharacterNextLevel(character_index)
    characterStats[character_index].next_level:set_text(character[character_index]:getNextXP(), -1)
end

function updateCharacterStrength(character_index)
    characterStats[character_index].strength:set_text(character[character_index]:getStrength(), -1)
end

function updateCharacterAgility(character_index)
    characterStats[character_index].agility:set_text(character[character_index]:getAgility(), -1)
end

function updateCharacterIntelligence(character_index)
    characterStats[character_index].intelligence:set_text(character[character_index]:getIntelligence(), -1)
end

function updateCharacterVitality(character_index)
    characterStats[character_index].vitality:set_text(character[character_index]:getVitality(), -1)
end

function updateCharacterLuck(character_index)
    characterStats[character_index].luck:set_text(character[character_index]:getLuck(), -1)
end

function updateCharacterDamage(character_index)
    characterStats[character_index].damage:set_text(character[character_index]:getDamage(), -1)
end

function updateCharacterHitPercent(character_index)
    characterStats[character_index].hit_percent:set_text(character[character_index]:getHitPercent(), -1)
end

function updateCharacterAbsorb(character_index)
    characterStats[character_index].absorb:set_text(character[character_index]:getAbsorb(), -1)
end

function updateCharacterEvadePercent(character_index)
    characterStats[character_index].evade_percent:set_text(character[character_index]:getEvadePercent(), -1)
end

function updateCharacterWeapon(character_index, slot)
    equipped = ''
    weapon = character[character_index]:getWeapon(slot)
    if weapon then
        if character[character_index]:getEquippedWeaponIndex() == slot then
            equipped = 'E - '
        end
        characterStats[character_index]['weapon_slot_' .. slot]:set_text(equipped .. weapon:getName(), -1)
    else
        characterStats[character_index]['weapon_slot_' .. slot]:set_text('', -1)
    end
end

function updateCharacterWeapons(character_index)
    for slot = 1,4 do
        updateCharacterWeapon(character_index, slot)
    end
end

function updateCharacterArmor(character_index, slot)
    equipped = ''
    armor = character[character_index]:getArmor(slot)
    if armor then
        if character[character_index]:getEquippedArmorIndex() == slot then
            equipped = 'E - '
          end
        characterStats[character_index]['armor_slot_' .. slot]:set_text(equipped .. armor:getName(), -1)
    else
        characterStats[character_index]['armor_slot_' .. slot]:set_text('', -1)
    end
end

function updateCharacterArmors(character_index)
    for slot = 1,4 do
        updateCharacterArmor(character_index, slot)
    end
end

function updateCharacterMagic(character_index, level, slot)
    magic = character[character_index]:getMagic(level, slot)
    if magic then
        characterStats[character_index]['magic_level_' .. level .. '_slot_' .. slot]:set_text(magic:getName(), -1)
    else
        characterStats[character_index]['magic_level_' .. level .. '_slot_' .. slot]:set_text('', -1)
    end
end

function updateCharacterMagics(character_index)
    for level=1,8 do
        for slot=1,3 do
            updateCharacterMagic(character_index, level, slot)
        end
    end
end

function updateCharacterMagicPoint(character_index, level)
    characterStats[character_index]['magic_points_level_' .. level]:set_text(character[character_index]:getMagicPoints(level), -1)
end

function updateCharacterMagicPoints(character_index)
    for level=1,8 do
        updateCharacterMagicPoint(character_index, level)
    end
end

function updateCharacterMaxMagicPoint(character_index, level)
    characterStats[character_index]['max_magic_points_level_' .. level]:set_text(character[character_index]:getMaxMagicPoints(level), -1)
end

function updateCharacterMaxMagicPoints(character_index)
    for level=1,8 do
        updateCharacterMaxMagicPoint(character_index, level)
    end
end

lastMap = nil
while (true) do
    map1 = character[1]:getHexMap()
    if map1 ~= lastMap1 then
        print(map1)
        lastMap1 = map1
    end
    map2 = character[2]:getHexMap()
    if map2 ~= lastMap2 then
        print(map2)
        lastMap2 = map2
    end
    map3 = character[3]:getHexMap()
    if map3 ~= lastMap3 then
        print(map3)
        lastMap3 = map3
    end
    map4 = character[4]:getHexMap()
    if map4 ~= lastMap4 then
        print(map4)
        lastMap4 = map4
    end
    frame_count = 0
    for index = 1,4 do
      frame_count = frame_count + 1
      if frame_count == 2 then
        emu.frameadvance()
        frame_count = 0
      end
      updateCharacterName(index)
      updateCharacterLevel(index)
      updateCharacterHP(index)
      updateCharacterMaxHP(index)
      updateCharacterExperience(index)
      updateCharacterNextLevel(index)
      updateCharacterStrength(index)
      updateCharacterAgility(index)
      updateCharacterIntelligence(index)
      updateCharacterVitality(index)
      updateCharacterLuck(index)
      updateCharacterDamage(index)
      updateCharacterHitPercent(index)
      updateCharacterAbsorb(index)
      updateCharacterEvadePercent(index)
      updateCharacterWeapons(index)
      updateCharacterArmors(index)
      updateCharacterMagics(index)
      updateCharacterMagicPoints(index)
      updateCharacterMaxMagicPoints(index)
    end
    emu.frameadvance()
end
