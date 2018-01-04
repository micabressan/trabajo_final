local TERMINAL_ID = 38
local REACTOR_SIDE = "back"
local WIDTH, HEIGHT = 50, 19

local LABELS = {
	main = "Reactor Control",
	energy = "Energy %d RF (%d%%)",
	production = ">> %d RF/T",
	fuel = "Fuel %d mB (%d%%)",
	consumption = ">> %.3f mB/T"
}

local COLORS = {
	text = colors.white,
	background = colors.black,
	energyFull = colors.red,
	energyEmpty = colors.gray,
	fuelFull = colors.yellow,
	fuelEmpty = colors.gray,
	active = colors.lime,
	inactive = colors.lightGray
}

local MAX_ENERGY = 10000000
local MAX_ACTIVATE = 0.4
local MIN_DEACTIVATE = 0.9

reactor = peripheral.wrap(REACTOR_SIDE)

local rterm = require "rterm"
local screen = rterm.connect(TERMINAL_ID)

local function write(text, textColor, backgroundColor, x, y)
	screen.setCursorPos(x, y)
	screen.setTextColor(textColor)
	screen.setBackgroundColor(backgroundColor)
	screen.write(text)
end

local function drawBar(fill, fillColor, emptyColor, x, y, w)
	local wc = math.floor(w * fill)

	screen.setCursorPos(x, y)
	screen.setBackgroundColor(fillColor)
	screen.write((" "):rep(wc))

	screen.setCursorPos(x + wc, y)
	screen.setBackgroundColor(emptyColor)
	screen.write((" "):rep(w - wc))
end

local function main()
	local fuelAmount = reactor.getFuelAmount()
	local fuelRelative = fuelAmount / reactor.getFuelAmountMax()
	local fuelConsumed = reactor.getFuelConsumedLastTick()

	local energyAmount = reactor.getEnergyStored()
	local energyRelative = energyAmount / MAX_ENERGY
	local energyProduced = reactor.getEnergyProducedLastTick()

	local fuelTemperature = reactor.getFuelTemperature()
	local casingTemperature = reactor.getCasingTemperature()

	local active = reactor.getActive()

	if active and energyRelative > MIN_DEACTIVATE then
		reactor.setActive(false)
	elseif not active and energyRelative < MAX_ACTIVATE then
		reactor.setActive(true)
	end

	active = reactor.getActive()

	screen.setBackgroundColor(COLORS.background)
	screen.clear()

	screen.setTextColor(COLORS.text)
	screen.setBackgroundColor(active and COLORS.active or COLORS.inactive)
	screen.setCursorPos(1, 1)
	screen.write(active and "O" or "X")

	write(LABELS.main, COLORS.text, COLORS.background, 3, 1)

	write(LABELS.energy:format(energyAmount, energyRelative * 100), COLORS.text, COLORS.background, 2, 3)
	write(LABELS.production:format(energyProduced), COLORS.energyFull, COLORS.background, 2, 4)
	drawBar(energyRelative, COLORS.energyFull, COLORS.energyEmpty, 1, 5, WIDTH)

	write(LABELS.fuel:format(fuelAmount, fuelRelative * 100), COLORS.text, COLORS.background, 2, 7)
	write(LABELS.consumption:format(fuelConsumed), COLORS.fuelFull, COLORS.background, 2, 8)
	drawBar(fuelRelative, COLORS.fuelFull, COLORS.fuelEmpty, 1, 9, WIDTH)

	screen.push()
end

while true do
	os.sleep(5)

	main()
end