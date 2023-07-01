-- Apex & Tez
-- Hostile Takeover

-- a quick "animation" suite made by NotQuiteApex
-- used to give the illusion that we made a game for the TezCo. Direct
-- we didn't, but wouldn't it be cool if we did?

-- some module shortcuts
-- if its not two letters, i don't use it often if at all
local la = love.audio
local ldt = love.data
local le = love.event
local lf = love.filesystem
local lfnt = love.font
local lg = love.graphics
local limg = love.image
local lj = love.joystick
local lk = love.keyboard
local ln = love.math
local lm = love.mouse
local lphy = love.physics
local lsnd = love.sound
local ls = love.system
local lt = love.thread
local ltmr = love.timer
local ltch = love.touch
local lvid = love.video
local lw = love.window


-- main

function love.load()
	-- some prep work
	lg.setDefaultFilter("nearest", "nearest")
	lg.setLineStyle("rough")

	GAME_STATE = "menu"
	GAME_CANV = lg.newCanvas(GAME_WIDTH, GAME_HEIGHT)

	-- Scene 1: The Fall
	-- Complete!
	s1_bg = lg.newImage("gfx/scene-fall.png")
	s1_tez = lg.newImage("gfx/tez-falling-32-35.png")
	s1_tez_frames = 8
	s1_tez_quad = {}
	local w,h = 32,35
	for i=0,s1_tez_frames-1 do
		s1_tez_quad[i+1] = lg.newQuad(i*w, 0, w, h, s1_tez:getWidth(), s1_tez:getHeight())
	end

	-- Scene 2: Battle - Greenway
	-- Complete!
	s2_bg = lg.newImage("gfx/battle-greenway.png")
	s2_jub = lg.newImage("gfx/enemy-jub-slime.png")
	s2_lute = lg.newImage("gfx/enemy-lute-lutebot.png")
	s2_lute_frames = 2
	s2_lute_quad = {}
	local w,h = 37,47
	for i=0,s2_lute_frames-1 do
		s2_lute_quad[i+1] = lg.newQuad(i*w, 0, w, h, s2_lute:getWidth(), s2_lute:getHeight())
	end

	-- Scene 3: Midwestern Hello (entrance dialogue)
	-- Complete!
	s3_bg = lg.newImage("gfx/scene-entrance.png")

	-- Scene 4: Battle - Sewer
	-- Complete!
	s4_bg = lg.newImage("gfx/battle-sewer.png")
	s4_jamie = lg.newImage("gfx/enemy-jamie-wambot.png")
	s4_jamie_frames = 2
	s4_jamie_quad = {}
	local w,h = 36,38
	for i=0,s4_jamie_frames-1 do
		s4_jamie_quad[i+1] = lg.newQuad(i*w, 0, w, h, s4_jamie:getWidth(), s4_jamie:getHeight())
	end
	s4_bee = lg.newImage("gfx/enemy-bee-beebot.png")

	-- Scene 5: Chat with Matt (office dialogue)
	-- Complete!
	s5_bg = lg.newImage("gfx/scene-matt.png")
	s5_bg_frames = 4
	s5_bg_quad = {}
	local w,h = 240,135
	for i=0,s5_bg_frames-1 do
		s5_bg_quad[i+1] = lg.newQuad(0, i*h, w, h, s5_bg:getWidth(), s5_bg:getHeight())
	end

	-- Scene 6: Battle - Office
	-- Complete!
	s6_bg = lg.newImage("gfx/battle-office.png")
	-- hylian & percy
	s6_hylian = lg.newImage("gfx/enemy-hylian-caster.png")
	s6_hylian_frames = 2
	s6_hylian_quad = {}
	local w,h = 33,54
	for i=0,s6_hylian_frames-1 do
		s6_hylian_quad[i+1] = lg.newQuad(i*w, 0, w, h, s6_hylian:getWidth(), s6_hylian:getHeight())
	end
	s6_percy = lg.newImage("gfx/enemy-percy-bunbot.png")
	s6_percy_frames = 2
	s6_percy_quad = {}
	local w,h = 35,52
	for i=0,s6_percy_frames-1 do
		s6_percy_quad[i+1] = lg.newQuad(i*w, 0, w, h, s6_percy:getWidth(), s6_percy:getHeight())
	end

	-- Scene 7: Battle - Finale
	-- Complete!
	s7_bg = lg.newImage("gfx/battle-finalboss.png")
	s7_bg:setWrap("mirroredrepeat", "repeat")
	s7_lorry = lg.newImage("gfx/battle-lorry.png")
	s7_hughes = lg.newImage("gfx/enemy-dr-hughes.png")
	s7_hughes_frames = 2
	s7_hughes_quad = {}
	local w,h = 47,83
	for i=0,s7_hughes_frames-1 do
		s7_hughes_quad[i+1] = lg.newQuad(i*w, 0, w, h, s7_hughes:getWidth(), s7_hughes:getHeight())
	end

	-- Scene 8: Promo Screen!
	-- Complete!
	s8_bg = lg.newImage("gfx/scene-promo.png")
	s8_title1 = lg.newImage("gfx/logo-top.png")
	s8_title2 = lg.newImage("gfx/logo-bottom.png")

	-- other
	ui_textbox = lg.newImage("gfx/ui-textbox.png")
	ui_battle = lg.newImage("gfx/ui-battle.png")
	ui_numbers = lg.newImageFont("gfx/ui-numbers.png", "0123456789", -3)
	ui_default_font = lg.newFont()
	
	ui_block_solo = lg.newImage("gfx/ui-block-solo.png")
	ui_block_duos = lg.newImage("gfx/ui-block-duos.png")
	ui_block_item = lg.newImage("gfx/ui-block-item.png")
	ui_block_run = lg.newImage("gfx/ui-block-run.png")

	apex_spr = lg.newImage("gfx/spr-apex.png")
	local w,h = apex_spr:getDimensions()
	apex_face_front = lg.newQuad(0, 0, 18, 34, w, h)
	apex_face_side = lg.newQuad(18, 0, 18, 34, w, h)
	apex_face_back = lg.newQuad(36, 0, 18, 34, w, h)
	apex_battle_frames = 2
	apex_battle = {
		lg.newQuad(0, 34, 22, 36, w, h),
		lg.newQuad(22, 34, 22, 36, w, h),
	}
	apex_dance = lg.newImage("gfx/spr-apex-dance.png")
	apex_dance_frames = 4
	apex_dance_quad = {}
	local w,h = 24,38
	for i=0,apex_dance_frames-1 do
		apex_dance_quad[i+1] = lg.newQuad(i*w, 0, w, h, apex_dance:getWidth(), apex_dance:getHeight())
	end

	tez_spr = lg.newImage("gfx/spr-tez.png")
	local w,h = tez_spr:getDimensions()
	tez_face_front = lg.newQuad(0, 0, 18, 34, w, h)
	tez_face_side = lg.newQuad(18, 0, 18, 34, w, h)
	tez_face_back = lg.newQuad(36, 0, 18, 34, w, h)
	tez_battle_frames = 2
	tez_battle = {
		lg.newQuad(0, 34, 22, 36, w, h),
		lg.newQuad(22, 34, 22, 36, w, h),
	}
	tez_dance = lg.newImage("gfx/spr-tez-dance.png")
	tez_dance_frames = 4
	tez_dance_quad = {}
	local w,h = 20,36
	for i=0,tez_dance_frames-1 do
		tez_dance_quad[i+1] = lg.newQuad(i*w, 0, w, h, tez_dance:getWidth(), tez_dance:getHeight())
	end
end

function love.update(dt)

end

function love.draw()
	local t = ltmr.getTime()

	-- draw the scene
	lg.setCanvas(GAME_CANV)
	lg.clear()
	if GAME_STATE == "menu" then
		lg.print(
			[[
Apex & Tez: Hostile Takeover!

To view any of the programmed scenes,
press any of the number keys.
Enjoy your stay.

- Apex ]]
		)
	elseif GAME_STATE == "1" then
		lg.draw(s1_bg)
		local t = (t * 2) % (s1_tez_frames + 4)
		local i = math.floor(t+1)
		if i < (s1_tez_frames+1) then
			lg.draw(s1_tez, s1_tez_quad[i], 140-t*3, 70-t*2, t+0.5, 1-0.15*(t%1), nil, 32/2, 35/2)
		end
	elseif GAME_STATE == "2" then
		lg.draw(s2_bg)

		lg.draw(s2_jub, 160, 80, 0, 1+0.15*math.sin(t*4), 1+0.15*math.sin(t*4+math.pi), s2_jub:getWidth()/4*3, s2_jub:getHeight())
		local i = math.floor((t * 20) % (s2_lute_frames) + 1)
		lg.draw(s2_lute, s2_lute_quad[i], 200, 100, 0, 1, 1, s2_lute:getWidth()/2, s2_lute:getHeight())
		local f = t+0.3
		lg.draw(s2_jub, 220, 120, 0, 1+0.15*math.sin(f*4), 1+0.15*math.sin(f*4+math.pi), s2_jub:getWidth()/4*3, s2_jub:getHeight())

		-- tez and apex
		-- local f = math.floor(((t+0.25) * 5) % (apex_battle_frames) + 1)
		-- lg.draw(apex_spr, apex_battle[f], 60, 50)
		local f = math.floor(((t+0.25) * 5) % (apex_dance_frames) + 1)
		lg.draw(apex_dance, apex_dance_quad[f], 60, 50)
		local f = math.floor((t * 4) % (tez_battle_frames) + 1)
		lg.draw(tez_spr, tez_battle[f], 24, 70)

		lg.draw(ui_block_item, 73-25, 32+2*math.sin(-2*t+3*math.pi/2), 0, 0.75, nil, 8, 10)
		lg.draw(ui_block_run,  73.25, 26+2*math.sin(-2*t+1*math.pi/1), 0, 0.5, nil, 8, 10)
		lg.draw(ui_block_duos, 73+25, 32+2*math.sin(-2*t+1*math.pi/2), 0, 0.75, nil, 8, 10)
		lg.draw(ui_block_solo, 73,    36+4*math.sin(-2*t+0*math.pi*0), 0, 1, 1, 8, 10)

		lg.draw(ui_battle)
		lg.setFont(ui_numbers)
		lg.print("14", 10, 106) -- Tez Health
		lg.print("14", 28, 118) -- Tez Points
		lg.print("20", 62, 106) -- Apex Health
		lg.print("8",  80, 118) -- Apex Points
		lg.setFont(ui_default_font)
	elseif GAME_STATE == "3" then
		local textTime = 1.25
		local color = {160/255, 135/255, 85/255}
		local color2 = {color[1]/2, color[2]/2, color[3]/2}
		local apexPoints = {132,66, 130,96, 140,96}
		local apexLine = "Well, it looks like its locked."
		local apexTime = 4
		local tezPoints = {106,66, 108,96, 98,96}
		local tezLine = "Yeah no shit sherlock."
		local tezTime = 3
		-- lg.print("TODO: Midwestern Hello")
		lg.draw(s3_bg)

		lg.draw(ui_textbox, 21, 94)
		-- lg.setColor(0, 0, 0)
		-- lg.printf("No Shit Sherlock!\nbitch.", 21+9, 94+4+2, 182)
		-- lg.setColor(1, 1, 1)

		local t = t % (apexTime + tezTime)

		if t < apexTime then
			-- lg.draw(ui_textbox, 21, 94)
			love.graphics.polygon("fill", apexPoints)
			lg.setColor(color)
			love.graphics.polygon("line", apexPoints)
			lg.setColor(color2)
			lg.printf(apexLine:sub(1, (t/textTime)*apexLine:len()), 21+9, 94+4+2, 182)
			lg.setColor(1, 1, 1)
		else
			-- lg.draw(ui_textbox, 21, 94)
			love.graphics.polygon("fill", tezPoints)
			lg.setColor(color)
			love.graphics.polygon("line", tezPoints)
			lg.setColor(color2)
			lg.printf(tezLine:sub(1, ((t-apexTime)/textTime)*tezLine:len()), 21+9, 94+4+2, 182)
			lg.setColor(1, 1, 1)
		end
	elseif GAME_STATE == "4" then
		lg.draw(s4_bg)

		lg.draw(s4_bee, 175+8*pingpong(t*10/math.pi), 88-math.abs(4*math.sin(t*10)), 0, 1, 1, s4_bee:getWidth()/2, s4_bee:getHeight(), 0-0.20*pingpong(t*10/math.pi)+0.13, 0)
		local i = math.floor((t * 20) % (s4_jamie_frames) + 1)
		lg.draw(s4_jamie, s4_jamie_quad[i], 220, 120, 0, 1, 1, s4_jamie:getWidth()/2, s4_jamie:getHeight())
		
		-- tez and apex
		local f = math.floor(((t+0.25) * 5) % (apex_battle_frames) + 1)
		lg.draw(apex_spr, apex_battle[f], 60, 50)
		local f = math.floor((t * 4) % (tez_battle_frames) + 1)
		lg.draw(tez_spr, tez_battle[f], 24, 70)
		
		lg.draw(ui_battle)
		lg.setFont(ui_numbers)
		lg.print("22", 10, 106) -- Tez Health
		lg.print("22", 28, 118) -- Tez Points
		lg.print("30", 62, 106) -- Apex Health
		lg.print("14", 80, 118) -- Apex Points
		lg.setFont(ui_default_font)
	elseif GAME_STATE == "5" then
		local textTime = 1.25
		local color = {160/255, 135/255, 85/255}
		local color2 = {color[1]/2, color[2]/2, color[3]/2}
		local mattPoints = {169,76, 172,40, 160,40}
		local mattLine = "I'm afraid the cheese buscuits aren't ready."
		local mattTime = 5
		local apexPoints = {130,74, 127,40, 139,40}
		local apexLine = "What the fuck are you talking about? Also can I have some."
		local apexTime = 6

		-- lg.print("TODO: Chat with Matt")
		local i = math.floor((t * 8) % (s5_bg_frames) + 1)
		lg.draw(s5_bg, s5_bg_quad[i])

		local t = t % (mattTime + apexTime)

		if t < mattTime then
			lg.draw(s5_bg, s5_bg_quad[i])
			lg.draw(ui_textbox, 21, 1)
			love.graphics.polygon("fill", mattPoints)
			lg.setColor(color)
			love.graphics.polygon("line", mattPoints)
			lg.setColor(color2)
			lg.printf(mattLine:sub(1, (t/textTime)*mattLine:len()), 21+9, 1+4+2, 182)
			lg.setColor(1, 1, 1)
		else
			lg.draw(s5_bg, s5_bg_quad[1])
			lg.draw(ui_textbox, 21, 1)
			love.graphics.polygon("fill", apexPoints)
			lg.setColor(color)
			love.graphics.polygon("line", apexPoints)
			lg.setColor(color2)
			lg.printf(apexLine:sub(1, ((t-mattTime)/textTime)*apexLine:len()), 21+9, 1+4+2, 182)
			lg.setColor(1, 1, 1)
		end
	elseif GAME_STATE == "6" then
		lg.draw(s6_bg)
		
		local i = math.floor((t * 8) % (s6_hylian_frames) + 1)
		lg.draw(s6_hylian, s6_hylian_quad[i], 220, 120+10*math.cos(t*2), 0, 1, 1, s6_hylian:getWidth()/2, s6_hylian:getHeight())
		local i = math.floor((t * 20) % (s6_percy_frames) + 1)
		lg.draw(s6_percy, s6_percy_quad[i], 175, 88, 0, 1, 1, s6_percy:getWidth()/2, s6_percy:getHeight())
		
		-- tez and apex
		local f = math.floor(((t+0.25) * 5) % (apex_battle_frames) + 1)
		lg.draw(apex_spr, apex_battle[f], 60, 46)
		-- local f = math.floor((t * 4) % (tez_battle_frames) + 1)
		-- lg.draw(tez_spr, tez_battle[f], 24, 70)
		local f = math.floor((t * 4) % (tez_dance_frames) + 1)
		lg.draw(tez_dance, tez_dance_quad[f], 28, 70)

		lg.draw(ui_block_duos, 37-25, 52-3+2*math.sin(-2*t+3*math.pi/2), 0, 0.75, nil, 8, 10)
		lg.draw(ui_block_solo, 37.25, 46-3+2*math.sin(-2*t+1*math.pi/1), 0, 0.5, nil, 8, 10)
		lg.draw(ui_block_item, 37+25, 52-3+2*math.sin(-2*t+1*math.pi/2), 0, 0.75, nil, 8, 10)
		lg.draw(ui_block_run,  37,    56-3+4*math.sin(-2*t+0*math.pi*0), 0, 1, 1, 8, 10)
		
		lg.draw(ui_battle)
		lg.setFont(ui_numbers)
		lg.print("34", 10, 106) -- Tez Health
		lg.print("29", 28, 118) -- Tez Points
		lg.print("45", 62, 106) -- Apex Health
		lg.print("21", 80, 118) -- Apex Points
		lg.setFont(ui_default_font)
	elseif GAME_STATE == "7" then
		local w,h = s7_bg:getDimensions()
		lg.draw(s7_bg, lg.newQuad(-t*400, 0, w, h, w, h))
		local m = math.floor((t*10)%1 + 0.5)
		lg.draw(s7_lorry, -1, 1-m)
		lg.draw(s7_hughes, s7_hughes_quad[1+math.floor((t*6)%1 + 0.5)], 160+math.sin(t*3+math.pi/1.5+0.5)*20, 30+math.cos(t*2)*12)

		local f = math.floor(((t+0.25) * 5) % (apex_battle_frames) + 1)
		lg.draw(apex_spr, apex_battle[f], 60, 50-m)
		local f = math.floor((t * 4) % (tez_battle_frames) + 1)
		lg.draw(tez_spr, tez_battle[f], 24, 70-m)

		lg.draw(ui_battle)
		lg.setFont(ui_numbers)
		lg.print("48", 10, 106) -- Tez Health
		lg.print("42", 28, 118) -- Tez Points
		lg.print("64", 62, 106) -- Apex Health
		lg.print("30", 80, 118) -- Apex Points
		lg.setFont(ui_default_font)
	elseif GAME_STATE == "8" then
		-- lg.print("TODO: Promo Screen!")
		lg.draw(s8_bg)
		lg.draw(s8_title2, 56/2, 22+1.75*math.sin(t))
		lg.draw(s8_title1, 64/2,  2+1.75*math.sin(t+math.pi/8))
	end
	lg.setCanvas()

	-- draw the "screen"
	local w,h = lg.getDimensions();
	lg.draw(GAME_CANV, 0,0, 0, w/GAME_WIDTH, h/GAME_HEIGHT)
end


-- callbacks

function love.keypressed(k)
	if k == "escape" then
		le.quit()
	end

	-- scene setting
	if k == "space" then
		GAME_STATE = "menu"
	elseif ("12345678"):find(k) then
		GAME_STATE = k
	end
end


-- functions from lume.lua

function pingpong(x)
	return 1 - math.abs(1 - x % 2)
end
