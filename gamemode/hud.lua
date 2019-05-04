--Colours

	--BackGround Colour
	local BackGroundColour = {}
	BackGroundColour.r = 50
	BackGroundColour.g = 50
	BackGroundColour.b = 50
	BackGroundColour.a = 75
	
	--BackgroundBar Colour
	local BackgroundBarColour = {}
	BackgroundBarColour.r = 0
	BackgroundBarColour.g = 0
	BackgroundBarColour.b = 0
	BackgroundBarColour.a = 255
	
	--Player Colour
	local PlayerColour = {}
	PlayerColour.r = 0
	PlayerColour.g = 255
	PlayerColour.b = 255
	PlayerColour.a = 100
	
	--Entity Colour
	local EntityColour = {}
	EntityColour.r = 255
	EntityColour.g = 255
	EntityColour.b = 0
	EntityColour.a = 100
	
	--Wall Colour
	local WallColour = {}
	WallColour.r = 255
	WallColour.g = 255
	WallColour.b = 255
	WallColour.a = 200
	
	--HealthBar Colour
	local HealthColour = {}
	HealthColour.r = 255
	HealthColour.g = 0
	HealthColour.b = 0
	HealthColour.a = 255
	
	--AmmoBar Colour
	local AmmoColour = {}
	AmmoColour.r = 0
	AmmoColour.g = 255
	AmmoColour.b = 0
	AmmoColour.a = 255
	
	--StaminaBar Colour
	local StaminaColour = {}
	StaminaColour.r = 0
	StaminaColour.g = 0
	StaminaColour.b = 255
	StaminaColour.a = 255
	
	--Entity Colour
	local ClockColour = {}
	ClockColour.r = 255
	ClockColour.g = 255
	ClockColour.b = 0
	ClockColour.a = 255
	
--Clock
function TSSClock()
	
	--Clock Window Settings
	local Clock = {}
	Clock.x = 100
	Clock.y = 0
	Clock.r = 25
	Clock.b = 10
	Clock.tl = false
	Clock.tr = false
	Clock.bl = true
	Clock.br = false
	
	Clock.x = Clock.x*(ScrW()/100)
	Clock.y = Clock.y*(ScrH()/100)
	
	local strTime = ""
	local tblTime = os.date( "!*t" , os.time() )
	if tblTime.hour < 10 then
		tblTime.hour = "0" .. tblTime.hour
	end
	if tblTime.min < 10 then
		tblTime.min = "0" .. tblTime.min
	end
	--PrintTable(tblTime)
	if math.mod(tblTime.sec,2) == 0 then
		strTime = tblTime.hour .. ":" .. tblTime.min
	else
		strTime = tblTime.hour .. " " .. tblTime.min
	end
	Clock.w,Clock.h = draw.SimpleText( strTime, "DermaLarge", (Clock.x-Clock.b), (Clock.y+Clock.b), ClockColour, TEXT_ALIGN_RIGHT)
	Clock.w = Clock.w+(Clock.b*2)
	Clock.h = Clock.h+(Clock.b*2)
	draw.RoundedBoxEx( Clock.r, (Clock.x-Clock.w), Clock.y, Clock.w, Clock.h, BackGroundColour, Clock.tl, Clock.tr, Clock.bl, Clock.br)
end

--Menu
function TSSMenu()
end

--Radar
function TSSRadar()
	local ply = LocalPlayer()
	local Player = player.GetAll()
	local Guard = ents.FindByClass( "tss_npc_guard" )
	local Zombie
	
	local PlyPos = ply:GetPos()
	local PlyAng = ply:GetAngles()
	local EyePos = ply:EyePos()
	local Dis = {}
	local Rad = {}
	
	local Radar = {}
	Radar.x = 10
	Radar.y = 10
	Radar.z = 3
	Radar.r = 100
	
	local Scan = true
	
	--local Old = {}
	--Old.x = 0
	--Old.y = 0
	
	draw.Circle((Radar.x+Radar.r),(Radar.y+Radar.r),Radar.r,720,BackGroundColour) --draw background
	
	for PlayerID = 1,#Player do -- for each player create 1 dot representing them
	
		--Declare Shared vars
		
		if (Player[PlayerID] == ply) then
			draw.Circle((Radar.x+Radar.r),(Radar.y+Radar.r),4,36,PlayerColour)
		else
			if (Player[PlayerID]:Alive()) then
				local EntPos = Player[PlayerID]:GetPos()
				--local Dis = {}
				Dis.x = EntPos.x - PlyPos.x
				Dis.y = EntPos.y - PlyPos.y
				Dis.z = EntPos.z - PlyPos.z
				Dis.r = ((Dis.x^2)+(Dis.y^2))^0.5
				Dis.a = math.deg(math.atan2(Dis.y,Dis.x))
				if ((math.Round(Dis.r,0)/16) <= 100/Radar.z) then
					Rad.a = math.Round(PlyAng.y,0)-math.Round(Dis.a,0)
					Rad.x = math.sin(math.rad(Rad.a))*Dis.r
					Rad.y = math.cos(math.rad(Rad.a))*Dis.r
					draw.Circle((Radar.x+Radar.r)+(Rad.x/16*Radar.z),(Radar.y+Radar.r)-(Rad.y/16*Radar.z),4,4,EntityColour)
				else 
				end
			end
		end
	end
	
	for GuardID = 1,#Guard do -- for each Guard create 1 dot representing them
	
		--Declare Shared vars
		
		if (Guard[GuardID] == ply) then
			draw.Circle((Radar.x+Radar.r),(Radar.y+Radar.r),4,36,PlayerColour)
		else
			if (Guard[GuardID]:IsNPC()) then
				local EntPos = Guard[GuardID]:GetPos()
				--local Dis = {}
				Dis.x = EntPos.x - PlyPos.x
				Dis.y = EntPos.y - PlyPos.y
				Dis.z = EntPos.z - PlyPos.z
				Dis.r = ((Dis.x^2)+(Dis.y^2))^0.5
				Dis.a = math.deg(math.atan2(Dis.y,Dis.x))
				if ((math.Round(Dis.r,0)/16) <= 100/Radar.z) then
					Rad.a = math.Round(PlyAng.y,0)-math.Round(Dis.a,0)
					Rad.x = math.sin(math.rad(Rad.a))*Dis.r
					Rad.y = math.cos(math.rad(Rad.a))*Dis.r
					draw.Circle((Radar.x+Radar.r)+(Rad.x/16*Radar.z),(Radar.y+Radar.r)-(Rad.y/16*Radar.z),4,4,EntityColour)
				else 
				end
			end
		end
	end
	if (Scan == true) then --wall scan for radar
		--/*
		local angmul = 1
		for Sang = 0,360 do
			
			--find begin pos for scan
			local Sbegin = Vector(0,0,0)
			Sbegin.x = PlyPos.x
			Sbegin.y = PlyPos.y
			Sbegin.z = EyePos.z+8
			
			--find end pos for scan
			local Send = Vector(0,0,0)
			Send.x = Sbegin.x + math.sin(math.rad(Sang*angmul))*Radar.r*16/Radar.z
			Send.y = Sbegin.y + math.cos(math.rad(Sang*angmul))*Radar.r*16/Radar.z
			Send.z = EyePos.z+8
			
			--declare input values for scan
			local ScanInput = {}
			ScanInput.start = Sbegin
			ScanInput.endpos = Send
			--ScanInput.filter
			ScanInput.mask = MASK_SOLID_BRUSHONLY
			ScanInput.ignoreworld = false
			
			--run scan
			local ScanOutput = util.TraceLine(ScanInput)
			
			if (ScanOutput.Hit) then
				--derive physical pos
				Dis.x = ScanOutput.HitPos.x - PlyPos.x
				Dis.y = ScanOutput.HitPos.y - PlyPos.y
				Dis.r = ((Dis.x^2)+(Dis.y^2))^0.5
				Dis.a = math.deg(math.atan2(Dis.y,Dis.x))
			
				--derive radar values for display
				Rad.a = math.Round(PlyAng.y,0)-math.Round(Dis.a,0)
				Rad.x = math.sin(math.rad(Rad.a))*Dis.r
				Rad.y = math.cos(math.rad(Rad.a))*Dis.r
			
				--draw dot
				draw.Rectangle((Radar.x+Radar.r)+(Rad.x/16*Radar.z),(Radar.y+Radar.r)-(Rad.y/16*Radar.z),1,1,WallColour)
			end
			
			--debug
			--used to debug eye sight aka old line code
			/*
			if(Old.x == 0 && Old.y == 0) then
				Old.x = Rad.x
				Old.y = Rad.y
			end
			
			draw.Line((Radar.x+Radar.r)+(Rad.x/16*Radar.z),(Radar.y+Radar.r)-(Rad.y/16*Radar.z),(Radar.x+Radar.r)+(Old.x/16*Radar.z),(Radar.y+Radar.r)-(Old.y/16*Radar.z),WallColour)
			
			Old.x = Rad.x
			Old.y = Rad.y
			*/
			--draw.Circle((Radar.x+Radar.r)+(Rad.x/16*Radar.z),(Radar.y+Radar.r)-(Rad.y/16*Radar.z),2,4,WallColour) --dot map
			--ply:PrintMessage(HUD_PRINTTALK,ScanOutput.MatType)
		end
		--*/
	end
end

--Stats overlay
function TSSStats(health,ammo,stamina) --WIP
	
	--Stat Window Settings
	local Stats = {}
	Stats.x = 0
	Stats.y = 90
	Stats.w = 25
	Stats.h = 10
	Stats.r = 25
	Stats.tl = false
	Stats.tr = true
	Stats.bl = false
	Stats.br = false
	
	Stats.x = Stats.x*(ScrW()/100)
	Stats.y = Stats.y*(ScrH()/100)
	Stats.w = Stats.w*(ScrW()/100)
	Stats.h = Stats.h*(ScrH()/100)
	
	--Large Bar Settings
	local Bar = {}
	Bar.w = 89
	Bar.h = 25
	Bar.r = 5
	Bar.tl = true
	Bar.tr = true
	Bar.bl = true
	Bar.br = true
	
	Bar.w = Bar.w*(Stats.w/100)
	Bar.h = Bar.h*(Stats.h/100)
	
	--ply:PrintMessage(HUD_PRINTTALK,plyhealth)
	draw.RoundedBoxEx( Stats.r, Stats.x, Stats.y, Stats.w, Stats.h, BackGroundColour, Stats.tl, Stats.tr, Stats.bl, Stats.br)
		
	--Health Bar
	draw.RoundedBoxEx( Bar.r, Stats.x+(5*(Stats.w/100)), Stats.y+(5*(Stats.h/100)), Bar.w, Bar.h, BackgroundBarColour, Bar.tl, Bar.tr, Bar.bl, Bar.br)
	if (health > 0) then
		draw.RoundedBoxEx( Bar.r, Stats.x+(5*(Stats.w/100)), Stats.y+(5*(Stats.h/100)), Bar.w*health, Bar.h, HealthColour, Bar.tl, Bar.tr, Bar.bl, Bar.br)
	end
	
	--Ammo Bar
	draw.RoundedBoxEx( Bar.r, Stats.x+(5*(Stats.w/100)), Stats.y+(35*(Stats.h/100)), Bar.w, Bar.h, BackgroundBarColour, Bar.tl, Bar.tr, Bar.bl, Bar.br)
	if (ammo > 0) then
		draw.RoundedBoxEx( Bar.r, Stats.x+(5*(Stats.w/100)), Stats.y+(35*(Stats.h/100)), Bar.w*ammo, Bar.h, AmmoColour, Bar.tl, Bar.tr, Bar.bl, Bar.br)
	end
	
	--Stamina Bar
	draw.RoundedBoxEx( Bar.r, Stats.x+(5*(Stats.w/100)), Stats.y+(65*(Stats.h/100)), Bar.w, Bar.h, BackgroundBarColour, Bar.tl, Bar.tr, Bar.bl, Bar.br)
	if (stamina > 0) then
		draw.RoundedBoxEx( Bar.r, Stats.x+(5*(Stats.w/100)), Stats.y+(65*(Stats.h/100)), Bar.w*stamina, Bar.h, StaminaColour, Bar.tl, Bar.tr, Bar.bl, Bar.br)
	end
	
end
