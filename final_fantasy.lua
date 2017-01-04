-- Most of the technical information provided by http://datacrystal.romhacking.net/wiki/Final_Fantasy:RAM_map

bit = require 'bit32'
lgi = require 'lgi'
character = require 'character'

--Gtk = lgi.Gtk
Gtk = lgi.require('Gtk', '3.0')
builder = Gtk.Builder()
builder:add_from_file('final_fantasy.glade')
window = builder:get_object('window')
buttonPressed = builder:get_object('button_pressed_value')
buttonRight = builder:get_object('right_button_value')
buttonLeft = builder:get_object('left_button_value')
buttonDown = builder:get_object('down_button_value')
buttonUp = builder:get_object('up_button_value')
buttonSelect = builder:get_object('select_button_value')
buttonStart = builder:get_object('start_button_value')
buttonB = builder:get_object('b_button_value')
buttonA = builder:get_object('a_button_value')
displayMode = builder:get_object('display_mode_value')
character1Name = builder:get_object('character_1_name_value')
character1Status = builder:get_object('character_1_status_value')
character1Experience = builder:get_object('character_1_xp_value')
character1HP = builder:get_object('character_1_hp_value')
character1Weapon = builder:get_object('character_1_weapon_value')
window:show_all()

--window = Gtk.Window()
--window.title = 'Test window'
--window:show_all()

gameRam = {
    buttonPressed = 0x0020,
    displayMode   = 0x000D,
}

armor = {
    [0x29] = "Cloth",
    [0x2a] = "Wooden Armor",
    [0x2b] = "Chain Armor",
    [0x2c] = "Iron Armor",
    [0x2d] = "Steel Armor",
    [0x2e] = "Silver Armor",
    [0x2f] = "Flame Armor",
    [0x30] = "Ice Armor",
    [0x31] = "Opal Armor",
    [0x32] = "Dragon Armor",
    [0x33] = "Copper Bracelet",
    [0x34] = "Silver Bracelet",
    [0x35] = "Gold Bracelet",
    [0x36] = "Opal Bracelet",
    [0x37] = "White Shirt",
    [0x38] = "Black Shirt",
    [0x39] = "Wooden Shield",
    [0x3a] = "Iron Shield",
    [0x3b] = "Silver Shield",
    [0x3c] = "Flame Shield",
    [0x3d] = "Ice Shield",
    [0x3e] = "Opal Shield",
    [0x3f] = "Aegis",
    [0x40] = "Buckler",
    [0x41] = "Procape",
    [0x42] = "Cape",
    [0x43] = "Wooden Helmet",
    [0x44] = "Iron Helmet",
    [0x45] = "Silver Helmet",
    [0x46] = "Opal Helmet",
    [0x47] = "Heal Helmet",
    [0x48] = "Ribbon",
    [0x49] = "Gloves",
    [0x4a] = "Copper Gauntlet",
    [0x4b] = "Iron Gauntlet",
    [0x4c] = "Silver Gauntlet",
    [0x4d] = "Zeus Gauntlet",
    [0x4e] = "Power Gauntlet",
    [0x4f] = "Opal Gauntlet",
    [0x50] = "Proring"
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
		name = character.character1:getName() --memory.readbyte(gameRam['character1'] + character['name'])
		character1Name:set_text(name, -1)
end

function updateCharacter1Status()
		character1Status:set_text(character.character1:getStatus(), -1)
end

function updateCharacter1Experience()
		character1Experience:set_text(character.character1:getExperience(), -1)
end

function updateCharacter1HP()
		character1HP:set_text(character.character1:getHP() .. ' / ' .. character.character1:getMaxHP(), -1)
end

function updateCharacter1Weapon()
    weapon = character.character1:getWeapon(1)
    character1Weapon:set_text(weapon:getName() .. ': ' .. weapon:getDamage() )
end

while (true) do
    updateButtonPressed()
    updateRightButton()
    updateLeftButton()
    updateDownButton()
    updateUpButton()
    updateStartButton()
    updateSelectButton()
    updateBButton()
    updateAButton()
    updateDisplayMode()
		updateCharacter1Name()
		updateCharacter1Status()
		updateCharacter1Experience()
		updateCharacter1HP()
    updateCharacter1Weapon()
    emu.frameadvance()
end
