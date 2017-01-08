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

character1 = {
    name = builder:get_object('character_1_name'),
    class = builder:get_object('character_1_class'),
    level = builder:get_object('character_1_level'),
    hp = builder:get_object('character_1_hp'),
    max_hp = builder:get_object('character_1_max_hp'),
    experience = builder:get_object('character_1_experience'),
    next_level = builder:get_object('character_1_next_level'),
    strength = builder:get_object('character_1_strength'),
    agility = builder:get_object('character_1_agility'),
    intelligence = builder:get_object('character_1_intelligence'),
    vitality = builder:get_object('character_1_vitality'),
    luck = builder:get_object('character_1_luck'),
    damage = builder:get_object('character_1_damage'),
    hit_percent = builder:get_object('character_1_hit_percent'),
    absorb = builder:get_object('character_1_absorb'),
    evade_percent = builder:get_object('character_1_evade_percent'),
    magic_level_1_slot_1 = builder:get_object('character_1_magic_level_1_slot_1'),
    magic_level_1_slot_2 = builder:get_object('character_1_magic_level_1_slot_2'),
    magic_level_1_slot_3 = builder:get_object('character_1_magic_level_1_slot_3'),
    magic_level_1_slot_4 = builder:get_object('character_1_magic_level_1_slot_4'),
    magic_level_2_slot_1 = builder:get_object('character_1_magic_level_2_slot_1'),
    magic_level_2_slot_2 = builder:get_object('character_1_magic_level_2_slot_2'),
    magic_level_2_slot_3 = builder:get_object('character_1_magic_level_2_slot_3'),
    magic_level_2_slot_4 = builder:get_object('character_1_magic_level_2_slot_4'),
    magic_level_3_slot_1 = builder:get_object('character_1_magic_level_3_slot_1'),
    magic_level_3_slot_2 = builder:get_object('character_1_magic_level_3_slot_2'),
    magic_level_3_slot_3 = builder:get_object('character_1_magic_level_3_slot_3'),
    magic_level_3_slot_4 = builder:get_object('character_1_magic_level_3_slot_4'),
    magic_level_4_slot_1 = builder:get_object('character_1_magic_level_4_slot_1'),
    magic_level_4_slot_2 = builder:get_object('character_1_magic_level_4_slot_2'),
    magic_level_4_slot_3 = builder:get_object('character_1_magic_level_4_slot_3'),
    magic_level_4_slot_4 = builder:get_object('character_1_magic_level_4_slot_4'),
    magic_level_5_slot_1 = builder:get_object('character_1_magic_level_5_slot_1'),
    magic_level_5_slot_2 = builder:get_object('character_1_magic_level_5_slot_2'),
    magic_level_5_slot_3 = builder:get_object('character_1_magic_level_5_slot_3'),
    magic_level_5_slot_4 = builder:get_object('character_1_magic_level_5_slot_4'),
    magic_level_6_slot_1 = builder:get_object('character_1_magic_level_6_slot_1'),
    magic_level_6_slot_2 = builder:get_object('character_1_magic_level_6_slot_2'),
    magic_level_6_slot_3 = builder:get_object('character_1_magic_level_6_slot_3'),
    magic_level_6_slot_4 = builder:get_object('character_1_magic_level_6_slot_4'),
    magic_level_7_slot_1 = builder:get_object('character_1_magic_level_7_slot_1'),
    magic_level_7_slot_2 = builder:get_object('character_1_magic_level_7_slot_2'),
    magic_level_7_slot_3 = builder:get_object('character_1_magic_level_7_slot_3'),
    magic_level_7_slot_4 = builder:get_object('character_1_magic_level_7_slot_4'),
    magic_level_8_slot_1 = builder:get_object('character_1_magic_level_8_slot_1'),
    magic_level_8_slot_2 = builder:get_object('character_1_magic_level_8_slot_2'),
    magic_level_8_slot_3 = builder:get_object('character_1_magic_level_8_slot_3'),
    magic_level_8_slot_4 = builder:get_object('character_1_magic_level_8_slot_4'),
    magic_points_level_1 = builder:get_object('character_1_level_1_magic_points'),
    magic_points_level_2 = builder:get_object('character_1_level_2_magic_points'),
    magic_points_level_3 = builder:get_object('character_1_level_3_magic_points'),
    magic_points_level_4 = builder:get_object('character_1_level_4_magic_points'),
    magic_points_level_5 = builder:get_object('character_1_level_5_magic_points'),
    magic_points_level_6 = builder:get_object('character_1_level_6_magic_points'),
    magic_points_level_7 = builder:get_object('character_1_level_7_magic_points'),
    magic_points_level_8 = builder:get_object('character_1_level_8_magic_points'),
    max_magic_points_level_1 = builder:get_object('character_1_level_1_max_magic_points'),
    max_magic_points_level_2 = builder:get_object('character_1_level_2_max_magic_points'),
    max_magic_points_level_3 = builder:get_object('character_1_level_3_max_magic_points'),
    max_magic_points_level_4 = builder:get_object('character_1_level_4_max_magic_points'),
    max_magic_points_level_5 = builder:get_object('character_1_level_5_max_magic_points'),
    max_magic_points_level_6 = builder:get_object('character_1_level_6_max_magic_points'),
    max_magic_points_level_7 = builder:get_object('character_1_level_7_max_magic_points'),
    max_magic_points_level_8 = builder:get_object('character_1_level_8_max_magic_points'),
    weapon_slot_1 = builder:get_object('character_1_weapon_slot_1'),
    weapon_slot_2 = builder:get_object('character_1_weapon_slot_2'),
    weapon_slot_3 = builder:get_object('character_1_weapon_slot_3'),
    weapon_slot_4 = builder:get_object('character_1_weapon_slot_4'),
    armor_slot_1 = builder:get_object('character_1_armor_slot_1'),
    armor_slot_2 = builder:get_object('character_1_armor_slot_2'),
    armor_slot_3 = builder:get_object('character_1_armor_slot_3'),
    armor_slot_4 = builder:get_object('character_1_armor_slot_4'),
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

function updateCharacter1Name()
    character1.name:set_text(character[1]:getName(), -1)
end

function updateCharacter1Level()
    character1.level:set_text("Level: " .. character[1]:getLevel(), -1)
end

function updateCharacter1HP()
    character1.hp:set_text(character[1]:getHP(), -1)
end

function updateCharacter1MaxHP()
    character1.max_hp:set_text(character[1]:getMaxHP(), -1)
end

function updateCharacter1Experience()
    character1.experience:set_text(character[1]:getExperience(), -1)
end

function updateCharacter1NextLevel()
    character1.next_level:set_text(character[1]:getNextXP(), -1)
end

function updateCharacter1Strength()
    character1.strength:set_text(character[1]:getStrength(), -1)
end

function updateCharacter1Agility()
    character1.agility:set_text(character[1]:getAgility(), -1)
end

function updateCharacter1Intelligence()
    character1.intelligence:set_text(character[1]:getIntelligence(), -1)
end

function updateCharacter1Vitality()
    character1.vitality:set_text(character[1]:getVitality(), -1)
end

function updateCharacter1Luck()
    character1.luck:set_text(character[1]:getLuck(), -1)
end

function updateCharacter1Damage()
    character1.damage:set_text(character[1]:getDamage(), -1)
end

function updateCharacter1HitPercent()
    character1.hit_percent:set_text(character[1]:getHitPercent(), -1)
end

function updateCharacter1Absorb()
    character1.absorb:set_text(character[1]:getAbsorb(), -1)
end

function updateCharacter1EvadePercent()
    character1.evade_percent:set_text(character[1]:getEvadePercent(), -1)
end

function updateCharacter1Weapon(slot)
    equipped = ''
    weapon = character[1]:getWeapon(slot)
    if weapon then
        if character[1]:getEquippedWeaponIndex() == slot then
            equipped = 'E - '
        end
        character1['weapon_slot_' .. slot]:set_text(equipped .. weapon:getName(), -1)
    else
        character1['weapon_slot_' .. slot]:set_text('', -1)
    end
end

function updateCharacter1Weapons()
    for slot = 1,4 do
        updateCharacter1Weapon(slot)
    end
end

function updateCharacter1Armor(slot)
    equipped = ''
    armor = character[1]:getArmor(slot)
    if armor then
        if character[1]:getEquippedArmorIndex() == slot then
            equipped = 'E - '
          end
        character1['armor_slot_' .. slot]:set_text(equipped .. armor:getName(), -1)
    else
        character1['armor_slot_' .. slot]:set_text('', -1)
    end
end

function updateCharacter1Armors()
    for slot = 1,4 do
        updateCharacter1Armor(slot)
    end
end

function updateCharacter1Magic(level, slot)
    magic = character[1]:getMagic(level, slot)
    if magic then
        character1['magic_level_' .. level .. '_slot_' .. slot]:set_text(magic:getName(), -1)
    else
        character1['magic_level_' .. level .. '_slot_' .. slot]:set_text('', -1)
    end
end

function updateCharacter1Magics()
    for level=1,8 do
        for slot=1,3 do
            updateCharacter1Magic(level, slot)
        end
    end
end

function updateCharacter1MagicPoint(level)
    character1['magic_points_level_' .. level]:set_text(character[1]:getMagicPoints(level), -1)
end

function updateCharacter1MagicPoints()
    for level=1,8 do
        updateCharacter1MagicPoint(level)
    end
end

function updateCharacter1MaxMagicPoint(level)
    character1['max_magic_points_level_' .. level]:set_text(character[1]:getMaxMagicPoints(level), -1)
end

function updateCharacter1MaxMagicPoints()
    for level=1,8 do
        updateCharacter1MaxMagicPoint(level)
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
    updateCharacter1Name()
    updateCharacter1Level()
    updateCharacter1HP()
    updateCharacter1MaxHP()
    updateCharacter1Experience()
    updateCharacter1NextLevel()
    updateCharacter1Strength()
    updateCharacter1Agility()
    updateCharacter1Intelligence()
    updateCharacter1Vitality()
    updateCharacter1Luck()
    updateCharacter1Damage()
    updateCharacter1HitPercent()
    updateCharacter1Absorb()
    updateCharacter1EvadePercent()
    updateCharacter1Weapons()
    updateCharacter1Armors()
    updateCharacter1Magics()
    updateCharacter1MagicPoints()
    updateCharacter1MaxMagicPoints()
    emu.frameadvance()
end
