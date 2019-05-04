
--execute files
include("shared.lua")
include("hud.lua")
include("lib/draw.lua")
--include("render.lua") --wip for later
--include("view.lua") --wip for later
include("menu.lua")
include("weather.lua")
include("time.lua")

--global varibles
local flashlight = flashlight or {}
local flashlightbool = flashlightbool or {}
local fdis = 0

--Functions

--Rendering

-- set attributes for rendering
local attrib = {
 [ "$pp_colour_addr" ] = 0,
 [ "$pp_colour_addg" ] = 0,
 [ "$pp_colour_addb" ] = 0,
 [ "$pp_colour_brightness" ] = 0,
 [ "$pp_colour_contrast" ] = 1,
 [ "$pp_colour_colour" ] = 1.50, --1.25 was previous
 [ "$pp_colour_mulr" ] = 0,
 [ "$pp_colour_mulg" ] = 0,
 [ "$pp_colour_mulb" ] = 0
}

local eyelightlevel = 0

local FullBody = false -- if this is true it makes the body visible but also makes guns a lower texture

function GM:RenderScreenspaceEffects()
	--set up light variables
	--going to try EyePos() instead of LocalPlayer():GetPos() so far so good
	
	--flash light val
	local flashlightlevel = 0.2
	
	--get values for light vectors
	local amblightlevel = render.GetAmbientLightColor()
	local plyheadlight = render.GetLightColor(EyePos())
	local plyfootlight = render.GetLightColor(LocalPlayer():GetPos())
	local aimlightlevel = render.GetLightColor(LocalPlayer():GetEyeTrace().HitPos)

	--turn vector colours in to average light level
	local amblightlevel =(math.sqrt((amblightlevel.x^2)+(amblightlevel.y^2)+(amblightlevel.z^2)))
	local plyheadlight = (math.sqrt((plyheadlight.x^2)+(plyheadlight.y^2)+(plyheadlight.z^2)))
	local plyfootlight = (math.sqrt((plyfootlight.x^2)+(plyfootlight.y^2)+(plyfootlight.z^2)))
	local aimlightlevel = (math.sqrt((aimlightlevel.x^2)+(aimlightlevel.y^2)+(aimlightlevel.z^2)))
	
	local plylightlevel = (plyheadlight+plyfootlight)/2
	local lightlevel = amblightlevel -- changed from (aimlightlevel+plylightlevel)/2
	
	--set light value based on which value is larger
	if (plyheadlight > plyfootlight && plylightlevel < plyheadlight) then
		plylightlevel = plyheadlight
	elseif (plyheadlight < plyfootlight && plylightlevel < plyfootlight) then
		plylightlevel = plyfootlight
	end
	
	--set light value based on which value is larger
	if (plylightlevel > aimlightlevel && lightlevel < plylightlevel) then
		lightlevel = plylightlevel
	elseif (plylightlevel < aimlightlevel && lightlevel < aimlightlevel) then
		lightlevel = aimlightlevel
	end
	
	if LocalPlayer():GetNWBool( "flashlight", false ) then
		lightlevel = lightlevel + flashlightlevel
	end
	
	if LocalPlayer():GetNWInt( "stunval", 0)<0 then
		eyelightlevel = LocalPlayer():GetNWInt( "stunval", 0)
	end
	
	--adjust eyes
	if (eyelightlevel < (math.Round(lightlevel,2))-0.01) then
		eyelightlevel = math.Round(eyelightlevel+0.0020,4)
	elseif (eyelightlevel > (math.Round(lightlevel,2))+0.01) then
		eyelightlevel = math.Round(eyelightlevel-0.0020,4)
	end
	
	--modify colour values WIP
	--attrib[ "$pp_colour_brightness" ] = 0 --(0.5-(eyelightlevel*(1/2)))
	--attrib[ "$pp_colour_contrast" ] = 1 --(1+(eyelightlevel*(1/2)))
	
	--LocalPlayer():PrintMessage(HUD_PRINTTALK," amblightlevel:"..amblightlevel.." plylightlevel:"..plylightlevel.." aimlightlevel:"..aimlightlevel.." lightlevel:"..lightlevel.." eyelightlevel:"..eyelightlevel)--Debug Dynamic Bloom
	
	DrawBloom(eyelightlevel*5,2,9,9,1,1,1,1,1) --0.85,0.65,0.60,0.20--2 was previous --Check why we use 5
	DrawColorModify(attrib)
	--DrawMaterialOverlay("effects/combine_binocoverlay",1)
	--DrawMaterialOverlay("effects/bleed_overlay",-0.005)
	--DrawMotionBlur(0,0,0)
	DrawSharpen(100000,0.001)
	--DrawSobel(10)
	--DrawSunbeams(0.80,0.1,0,0.5,0.5)
	--DrawTexturize(1,Material("pp/texturize/pattern1.png"))
	DrawToyTown(1,100)
end

local SunObstruction = 0

local function DrawSunRays()
	local sun = util.GetSunInfo()
	if (!sun or sun.obstruction == 0) then 
		return 
	end
	
	if (SunObstruction < (math.Round(sun.obstruction,2))-0.01) then
		SunObstruction = math.Round(SunObstruction+0.0160,4)
	elseif (SunObstruction > (math.Round(sun.obstruction,2))+0.01) then
		SunObstruction = math.Round(SunObstruction-0.0160,4)
	end
	
	local SunWPos = EyePos() + sun.direction * 4096
	local SunSPos = SunWPos:ToScreen()
	local dot = (sun.direction:Dot(EyeVector()))*5
	if (dot <= 0) then 
		return 
	end
	--LocalPlayer():PrintMessage(HUD_PRINTTALK,SunSPos.x.." "..SunSPos.y) --debug sun position on screen
	if (SunSPos.x <= 75 or SunSPos.y <= 75 or SunSPos.x >= ScrW()-75 or SunSPos.y >= ScrH()-75) then
		DrawSunbeams(0.95/SunObstruction,0.25*SunObstruction,0.05*SunObstruction,SunSPos.x/ScrW(),SunSPos.y/ScrH()); --use around border
	else
		DrawSunbeams(0.95*SunObstruction,0.25*SunObstruction,0.05*SunObstruction,SunSPos.x/ScrW(),SunSPos.y/ScrH()); --use for objects
	end
end
hook.Add("RenderScreenspaceEffects","SunRays",DrawSunRays)

function FlashlightDraw() --flashlight code major WIP
	if (GetConVar("tss_iflashlight"):GetBool() == true) then
		local Player = player.GetAll()
		for PlayerID = 1,#Player do
			local nbool = Player[ PlayerID ]:GetNWBool( "flashlight", false )
			if (nbool != flashlightbool[ Player[ PlayerID ] ]) then
				if nbool then
					local color = {}
					color.r = 255
					color.g = 255
					color.b = 255
					color.a = 255
					local light = ProjectedTexture()
					local boneid = Player[ PlayerID ]:LookupBone( "ValveBiped.Bip01_L_Hand" )
					local bonepos = Player[ PlayerID ]:GetBonePosition( boneid )
					light:SetAngles( Player[ PlayerID ]:EyeAngles() )
					light:SetPos( bonepos ) --Player[ PlayerID ]:EyePos() 
					light:SetColor( color )
					if #Player <= 8 then
						light:SetEnableShadows( true ) 
					else
						light:SetEnableShadows( false ) 
					end
					light:SetNearZ( 1 )					
					light:SetFarZ( 750 )
					light:SetFOV( 60 )
					light:SetTexture( "effects/flashlight001" )
					light:Update()
					flashlight[ Player[ PlayerID ] ] = light
				else
					if IsValid(flashlight[ Player[ PlayerID ] ]) then
						flashlight[ Player[ PlayerID ] ]:Remove()
						flashlight[ Player[ PlayerID ] ] = nil
					end
				end
				if (Player[ PlayerID ] == LocalPlayer()) then
					surface.PlaySound( "items/flashlight1.wav" ) --WIP
				end
				flashlightbool[ Player[ PlayerID ] ] = nbool
			else
				if nbool then
					if #Player <= 8 then
						flashlight[ Player[ PlayerID ] ]:SetEnableShadows( true ) 
					else
						flashlight[ Player[ PlayerID ] ]:SetEnableShadows( true ) 
					end
					local boneid = Player[ PlayerID ]:LookupBone( "ValveBiped.Bip01_L_Hand" )
					local bonepos = Player[ PlayerID ]:GetBonePosition( boneid )
					flashlight[ Player[ PlayerID ] ]:SetAngles( Player[ PlayerID ]:EyeAngles() )
					flashlight[ Player[ PlayerID ] ]:SetPos( bonepos ) --Player[ PlayerID ]:EyePos() 
					
					--Begin WIP experimental flashlight code
					if (GetConVar("tss_experimental"):GetBool()) then --WIP
						local defaultfarz = 750 
						local xyz = (Player[ PlayerID ]:GetEyeTrace().HitPos)-(Player[ PlayerID ]:EyePos())
						local dis = math.sqrt((xyz.x * xyz.x) + (xyz.y * xyz.y) + (xyz.z * xyz.z))
					
						if (defaultfarz>dis) then
							flashlight[ Player[ PlayerID ] ]:SetFarZ( dis+50 )
							fdis = dis
						else
							if fdis<750 then
								fdis = fdis + 1
							elseif fdis>750 then
								fdis = fdis - 1
							end
							flashlight[ Player[ PlayerID ] ]:SetFarZ( fdis+100 )
						end
					end
					--End WIP
					
					flashlight[ Player[ PlayerID ] ]:Update()
				end
			end	
		end
	end
end

--Body View Functions

function BodyView(ply,pos,ang,fov) --set view --wip
	local view = {}
	if (ply:Alive()) then
		if (FullBody) then
			local eyesid = ply:LookupAttachment("eyes")
			local eyes = ply:GetAttachment(eyesid)
			view.origin = eyes.Pos
			view.angles = ang
			view.fov = fov
			view.angles.p = (eyes.Ang.p*10 + ang.p*90)/100 -- ok for use for body view --wip
			view.angles.r = (eyes.Ang.r*50 + ang.r*50)/100 -- ok for use for body view --wip
		else
			view.origin = pos
			view.angles = ang
			view.fov = fov
		end
	else
		local ragdoll = ply:GetRagdollEntity()
		if (IsValid(ragdoll)) then
			local eyesid = ragdoll:LookupAttachment("eyes")
			local eyes = ragdoll:GetAttachment(eyesid)
			view.origin = eyes.Pos
			view.angles = eyes.Ang
		else
			--local eyesid = ply:LookupAttachment("eyes")
			--local eyes = ply:GetAttachment(eyesid)
			view.origin = pos
			view.angles = ang
			view.fov = fov
		end
	end
	FlashlightDraw()
	return view
end
hook.Add("CalcView","FPView",BodyView)

--draw player for use in future full body experience
function GM:ShouldDrawLocalPlayer(ply)
	return FullBody
end

--highlight ent that is being looked at
function FocusHalo()
	local tr = LocalPlayer():GetEyeTrace()
	if (tr.Hit) then 
		if (!tr.HitNoDraw) && (tr.HitNonWorld) then
			if string.find(tr.Entity:GetClass(), "tss_weapon_" ) or string.find(tr.Entity:GetClass(), "tss_ammo_" ) or string.find(tr.Entity:GetClass(), "tss_item_" ) then
				local dis = tr.HitPos - tr.StartPos
				dis = math.sqrt((dis.x*dis.x) + (dis.y*dis.y) + (dis.z*dis.z))
				if (dis < 93) then
					local entities = {tr.Entity}
					halo.Add( entities, Color( 255, 255, 255 ),0,0,1,true,true)
				end
			end
		end
	end
end
hook.Add( "PreDrawHalos", "FocusHalo", FocusHalo)

--set eye position
--LocalPlayer():SetEyeAngles((LocalPlayer():GetShootPos()):Angle()) -- works in client only buggy

--Drop Function

--keep spawn menu function
function GM:SpawnMenuEnabled()
	return true	
end

--drop current weapon
function GM:OnSpawnMenuOpen()
	--remove ghost entities
	local ActiveWeapon = LocalPlayer():GetActiveWeapon()
	if IsValid(ActiveWeapon) then
		if IsValid( ActiveWeapon.GhostEntity ) then
			ActiveWeapon.GhostEntity:Remove()
			ActiveWeapon.GhostEntity = nil
		end
	end
	--drop the weapon
	RunConsoleCommand("tss_dropweapon")
	return false
end

--ScoreBoard

function GM:ScoreboardShow()
	ScoreBoardOpen()
end

function GM:ScoreboardHide()
	ScoreBoardClose()
end

--HUD Config

--get rid of player name and health that shows up when you look at a player
function GM:HUDDrawTargetID()
	return false
end

function GM:HUDItemPickedUp(item)
	return false
end

--remove parts of hud that are not required
function GM:HUDShouldDraw(element)
	for key,value in pairs{"CHudHealth","CHudBattery","CHudAmmo","CHudSecondaryAmmo","CHudDamageIndicator","CHudVoiceStatus","CHudVoiceSelfStatus","CHudPoisonDamageIndicator"} do --hide selected items
		if element == value then 
			return false 
		end
	end
	return true
end

--draw hud
function GM:HUDPaint()
	local ply = LocalPlayer() --set ply as local player
	if (ply:Alive()) then
	
		TSSClock()
		TSSMenu()
		TSSRadar()
		
		local ply = LocalPlayer()
		local Player = player.GetAll()
		
		local plyhealth = ply:Health()
		local health = (plyhealth/100)
		
		local ammo = 0
		if (IsValid(ply:GetActiveWeapon())) then --fixes errors because of unexpected deaths
			ammo = ((ply:GetActiveWeapon():Clip1())/(ply:GetActiveWeapon():GetMaxClip1()))
		end
		
		local stamina = 1
		stamina = (ply:GetNWFloat( "stamina", 0 )/100)
		
		TSSStats(health,ammo,stamina)
	end
end