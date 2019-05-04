--server-side code resides here

--send files to client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("hud.lua")
AddCSLuaFile("lib/draw.lua")
AddCSLuaFile("menu.lua")
AddCSLuaFile("weather.lua")
AddCSLuaFile("time.lua")

--execute files
include("shared.lua")
include("assets/music.lua")
include("assets/voices.lua")
include("assets/playermodels.lua")
include("ent_replace.lua")
include("ent_create.lua")
include("debug.lua")
include("weather.lua")
include("time.lua")

--add resources

--global varibles
local deploying = false
local flashlight = flashlight or {}

--Functions

--Spawn Functions

function CreateEntities()
	CreatePoints()
end
hook.Add( "InitPostEntity", "initcreateentities",CreateEntities)

function ReplaceEntities() --WIP
	ReplacePoints()
	ReplaceObjects()
	ReplaceItems()
	ReplaceWeapons()
	ReplaceAmmo()
end
hook.Add( "InitPostEntity", "initreplaceentities",ReplaceEntities)

function GM:PlayerInitialSpawn(ply) --WIP
	ply:SetTeam( 1 )
	ply:ConCommand( "tss_mainmenu" ) --kind of hacky and can be called at any time using the command try to fix this later on.
end

function GM:PlayerSpawn(ply)

	--reset player values
	SetupPlayerVars(ply)

	ply:UnSpectate()
	
	player_manager.OnPlayerSpawn(ply)
	player_manager.RunClass(ply,"Spawn")
	
	-- Call item loadout function
	hook.Call("PlayerLoadout",GAMEMODE,ply)
	
	-- Set player model
	hook.Call("PlayerSetModel",GAMEMODE,ply)
	
	ply:SetupHands()
	
end

--set player model
function GM:PlayerSetModel(ply)
	if (math.random(0,1) == 1) then
		ply:SetModel(PMMaleCitizen[math.random(#PMMaleCitizen)])--set random player model from array
		--ply:EmitSound(VMale[math.random(#VMale)],75,100,1,CHAN_AUTO) -- use V as prefix
	else
		ply:SetModel(PMFemaleCitizen[math.random(#PMFemaleCitizen)])--set random player model from array
		--ply:EmitSound(VMale[math.random(#VMale)],75,100,1,CHAN_AUTO) -- use V as prefix
	end
	ply:SetPlayerColor(Vector((math.random(101)-1)/200,(math.random(101)-1)/200,(math.random(101)-1)/200))--set random player colour minimum 100 higher the number the darker the colour
	end

--setup player hands	
function GM:PlayerSetHandsModel(ply,ent)
	local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
	local hands = player_manager.TranslatePlayerHands(simplemodel)
	if (hands) then
		ent:SetModel(hands.model)
		ent:SetSkin(hands.skin)
		ent:SetBodyGroups(hands.body)
	end
end

--deploy loadouts
function GM:PlayerLoadout(ply)
	deploying = true
	ply:ShouldDropWeapon(true)
	ply:StripWeapons()
	ply:Give("tss_weapon_fists")
	--ply:Give("weapon_physgun")
	--ply:GiveAmmo(100,"357",true)
	--ply:Give("weapon_357")
	deploying = false
end

function SetupPlayerVars(ply)
	ply:SetNWFloat( "stamina", 100)
end

--fade in player screen
function PlayerFadeIn(ply)
	ply:ScreenFade(SCREENFADE.IN,color_black,5,0)
	Faded = false
end
hook.Add("PlayerLoadout","SpawnFadeIn",PlayerFadeIn)

--Player Actions

--SwimCheck
function PlayerStaminaHandler() --WIP
	local Player = player.GetAll()
	for PlayerID = 1,#Player do
		if (Player[PlayerID]:Alive()) then
			if (Player[PlayerID]:WaterLevel() == 3) then
			
				if Player[PlayerID]:GetNWFloat( "stamina", 0 ) > 0 then
					Player[PlayerID]:SetNWFloat( "stamina", Player[PlayerID]:GetNWFloat( "stamina", 0 ) - 0.1 )
				else
					if Player[PlayerID]:Health() > 0 then
						--Player[PlayerID]:SetHealth(Player[PlayerID]:Health() - 0.025)
					else
					end
				end
				
			elseif Player[PlayerID]:KeyDown(IN_SPEED) and (Player[PlayerID]:KeyDown(IN_FORWARD) or Player[PlayerID]:KeyDown(IN_MOVELEFT) or Player[PlayerID]:KeyDown(IN_BACK) or Player[PlayerID]:KeyDown(IN_MOVERIGHT))then
				if Player[PlayerID]:GetNWFloat( "stamina", 0 ) > 0 then
					Player[PlayerID]:SetNWFloat( "stamina", Player[PlayerID]:GetNWFloat( "stamina", 0 ) - 0.1 )
				else
				end
			else
				if Player[PlayerID]:GetNWFloat( "stamina", 0 ) < 100 then
					Player[PlayerID]:SetNWFloat( "stamina", Player[PlayerID]:GetNWFloat( "stamina", 0 ) + 0.025 )
				else
					if Player[PlayerID]:Health() < Player[PlayerID]:GetMaxHealth() then
						--Player[PlayerID]:SetHealth(Player[PlayerID]:Health() + 1)
					else
					end
				end
			end
		end
		
		--set move modifier --note using half of stamina is most effective
		Player[PlayerID]:SetMaxSpeed(30+(50+(240*(Player[PlayerID]:GetNWFloat( "stamina", 0 ) / 100)))*(Player[PlayerID]:Health() / 100))
		Player[PlayerID]:SetRunSpeed(30+(50+(210*(Player[PlayerID]:GetNWFloat( "stamina", 0 ) / 100)))*(Player[PlayerID]:Health() / 100))
		Player[PlayerID]:SetWalkSpeed(30+(50+(90*(Player[PlayerID]:GetNWFloat( "stamina", 0 ) / 100)))*(Player[PlayerID]:Health() / 100))
		Player[PlayerID]:SetCrouchedWalkSpeed(((-1+0.60000002384186)*(Player[PlayerID]:Health() / 100))+1)
		
	end
end
hook.Add("Think","StaminaHandler",PlayerStaminaHandler)

--pickup current weapon
function GM:PlayerCanPickupWeapon(ply, wep) --WIP
	if (deploying) then 
		return true 
	end
	if (ply:KeyDown(IN_USE)) then
		if (string.find(string.lower(wep:GetClass()), "tss_weapon_")) then
			if (!ply:HasWeapon(wep:GetClass())) then
				local types = {
					"_pistol_",
					"_smg_",
					"_shotgun_",
					"_rifle_",
					"_sniperrifle_"}
				for ci=1,#types do
					if (string.find(string.lower(wep:GetClass()), types[ci])) then
						local inv = ply:GetWeapons()
						for cii=1,#inv do
							if inv[cii] then
								if (string.find(string.lower(inv[cii]:GetClass()), types[ci])) then
									return false
								end
							end
						end
					end
				end
				if (ply:GetEyeTrace().Entity == wep) then
					return true
				end
			end
		end
	end	
	return false
end

--drop current weapon except for fists
concommand.Add("tss_dropweapon",function(ply)
	if (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() ~= "tss_weapon_fists") then
		ply:DropWeapon(ply:GetActiveWeapon())
	end
end)

--control use of flashlights
function GM:PlayerSwitchFlashlight(ply,desiredState)
	if (GetConVar("tss_iflashlight"):GetBool() == false) then
		if (desiredState == false) then -- the player wants to turn the flashlight off
			return true -- always allow
		elseif (GetConVar("tss_flashlight"):GetBool() == true) then
			return true -- allow if tss_flashlight is enabled
		end
		return false
	else
		if ply:Alive() then
			if flashlight[ ply ] then
				flashlight[ ply ] = false
				ply:SetNWBool( "flashlight", false )
			elseif (GetConVar("tss_flashlight"):GetBool() == true) then
				flashlight[ ply ] = true
				ply:SetNWBool( "flashlight", true )
			end
		else
			flashlight[ ply ] = false
			ply:SetNWBool( "flashlight", false )
		end
		return false
	end
end

function GM:ShowTeam( ply )
	if GetGlobalInt( "RoundEndTime", 0 ) < 0 then
		ply:ConCommand( "tss_mainmenu" )
	end
end

function GM:PlayerCanHearPlayersVoice( listener, talker )
	return listener:Visible( talker ), true
end

--control use of spray
function GM:PlayerSpray(ply)
	if (GetConVar("tss_spray"):GetBool() == true) then
		return false -- allow if tss_spray is enabled
	end
	return true
end

function GM:CanPlayerSuicide(ply)
	if (ply:Alive() and (GetConVar("tss_suicide"):GetBool() == true))then
		return true
	else
		return false
	end
end

--Player Damage Functions

--set fall damage
function GM:GetFallDamage(ply,speed)
	local speed = math.floor(speed)
	local health = math.floor(ply:Health())
	local dmg = math.ceil((speed-health)/5)
	--ply:PrintMessage(HUD_PRINTTALK,"speed:"..speed.." damage:"..dmg.." health:"..ply:Health()) --debug player fall damage
	return (dmg)
end

--Player Death Functions

--Death normal
/*
function GM:PlayerDeath(ply,inflictor,attacker)
	--set spawn time
	ply.NextSpawnTime = CurTime()+2
	ply.DeathTime = CurTime()
end
*/

local FadeOutEnd = 0

--Death think
function GM:PlayerDeathThink(ply)
	local CorpseVelocity = ply:GetVelocity()

	--decide if corpse has stopped moving
	if (Faded == false) then
		if (ply:IsOnGround() && CorpseVelocity.x == 0 && CorpseVelocity.y == 0 && CorpseVelocity.z == 0) then
			ply:ScreenFade(SCREENFADE.OUT,color_black,5,1)
			FadeOutEnd = math.floor(CurTime()+6)
			Faded = true
		end
	end
	
	--make the screen black
	if (math.floor(CurTime()) == FadeOutEnd) then
		ply:ScreenFade(SCREENFADE.STAYOUT,color_black,0,1)
	end
	
	--check to see if player can spawn now
	if (FadeOutEnd > CurTime() || ply.NextSpawnTime && ply.NextSpawnTime > CurTime()) then
		return 
	end
	
	--see if player is trying to spawn
	if (ply:IsBot() || ply:KeyPressed(IN_ATTACK) || ply:KeyPressed(IN_ATTACK2) || ply:KeyPressed(IN_JUMP)) then
		ply:Spawn()
	end
end

--mute default flat-line sound
function GM:PlayerDeathSound()
	return true
end
 
--add blood splatters to rag-dolls
function EntBloodHandler(ent,dmginfo)
	if (GetConVar("tss_blood"):GetBool() == true) then
		if ((ent:GetClass() == "prop_ragdoll") || (ent:GetClass() == "player") || (string.find(string.lower(ent:GetClass()), "npc_"))) then
			local effect = EffectData()  
			local origin = dmginfo:GetDamagePosition()
			effect:SetOrigin(origin)
			util.Effect("bloodimpact", effect) 
			local startp = dmginfo:GetDamagePosition()
			local traceinfo = {start = startp, endpos = startp - Vector(0,0,50), filter = ent, mask = MASK_NPCWORLDSTATIC}
			local trace = util.TraceLine(traceinfo)
			local todecal1 = trace.HitPos + trace.HitNormal
			local todecal2 = trace.HitPos - trace.HitNormal
			util.Decal("Blood", todecal1, todecal2)
		end
		--Add WIP bleed out code here
		--use a for loop mate for every 10 dmg give one splat
	end
end
hook.Add("EntityTakeDamage", "BloodHandler", EntBloodHandler)