--varibles
local weapon = { --WIP
	--hl2
	--["weapon_crowbar"] = "tss_weapon_c4",
	["weapon_rpg"] = "tss_point_spawner_weapon_grenade_h",
	["weapon_slam"] = "tss_point_spawner_weapon_grenade_s",
	["weapon_frag"] = "tss_point_spawner_weapon_grenade_f",
	["weapon_smg1"] = "tss_point_spawner_weapon_smg",
	["weapon_shotgun"] = "tss_point_spawner_weapon_shotgun",
	["weapon_357"] = "tss_point_spawner_weapon_pistol",
	["weapon_ar2"] = "tss_point_spawner_weapon_rifle",
	["weapon_crossbow"] = "tss_point_spawner_weapon_sniperrifle",
	--dod
	--css
	--tf2
	["item_ammopack_small"] = "tss_point_spawner_weapon_random",
	["item_ammopack_medium"] = "tss_point_spawner_weapon_random",
	["item_ammopack_full"] = "tss_point_spawner_weapon_random",
	--ttt
	["ttt_random_weapon"] = "tss_point_spawner_weapon_random",
	["weapon_zm_molotov"] = "tss_point_spawner_weapon_grenade_f",
	["weapon_ttt_smokegrenade"] = "tss_point_spawner_weapon_grenade_s",
	["weapon_ttt_confgrenade"] = "tss_point_spawner_weapon_grenade_h",
	--["weapon_zm_sledge"] = "tss_weapon_c4",
	["weapon_zm_pistol"] = "tss_point_spawner_weapon_pistol",
	["weapon_ttt_glock"] = "tss_point_spawner_weapon_pistol",
	["weapon_zm_revolver"] = "tss_point_spawner_ammo_rifle",
	["weapon_zm_shotgun"] = "tss_point_spawner_weapon_shotgun",
	["weapon_zm_mac10"] = "tss_point_spawner_weapon_smg",
	["weapon_ttt_m16"] = "tss_point_spawner_weapon_pistol",
	["weapon_zm_rifle"] = "tss_point_spawner_weapon_sniperrifle",
	--hl1d
	["weapon_9mmAR"] = "tss_point_spawner_weapon_smg",
	["weapon_9mmhandgun"] = "tss_point_spawner_weapon_pistol",
	["weapon_egon"] = "tss_point_spawner_weapon_rifle",
	["weapon_gauss"] = "tss_point_spawner_weapon_smg",
	["weapon_handgrenade"] = "tss_point_spawner_weapon_grenade_f",
	["weapon_hornetgun"] = "tss_point_spawner_weapon_rifle",
	["weapon_satchel"] = "tss_point_spawner_weapon_grenade_h",
	["weapon_snark"] = "tss_point_spawner_weapon_random",
	["weapon_tripmine"] = "tss_point_spawner_weapon_grenade_s",
	["weaponbox"] = "tss_point_spawner_weapon_random",
	--zs
	["item_healthvial"] = "tss_point_spawner_weapon_random"}
	
local ammo = { --WIP
	--hl2
	["item_ammo_crate"] = "tss_point_spawner_ammo_random",
	["item_item_crate"] = "tss_point_spawner_ammo_random",
	["item_ammo_357"] = "tss_point_spawner_ammo_pistol",
	["item_ammo_pistol"] = "tss_point_spawner_ammo_pistol",
	["item_ammo_revolver"] = "tss_point_spawner_ammo_rifle",
	["item_ammo_357_large"] = "tss_point_spawner_ammo_pistol",
	["item_ammo_smg1"] = "tss_point_spawner_ammo_smg",
	["item_ammo_smg1_grenade"] = "tss_point_spawner_ammo_smg",
	["item_ammo_ar2"] = "tss_point_spawner_ammo_rifle",
	["item_ammo_ar2_large"] = "tss_point_spawner_ammo_rifle",
	["item_ammo_ar2_altfire"] = "tss_point_spawner_ammo_rifle",
	["item_box_buckshot"] = "tss_point_spawner_ammo_shotgun",
	["item_rpg_round"] = "tss_point_spawner_ammo_sniperrifle",
	["item_ammo_crossbow"] = "tss_point_spawner_ammo_sniperrifle",
	--dod
	--css
	--tf2
	["item_healthkit_small"] = "tss_point_spawner_ammo_random",
	["item_healthkit_medium"] = "tss_point_spawner_ammo_random",
	["item_healthkit_full"] = "tss_point_spawner_ammo_random",
	--ttt
	["ttt_random_ammo"] = "tss_point_spawner_ammo_random",
	["item_ammo_357_ttt"] = "tss_point_spawner_ammo_sniperrifle",
	["item_ammo_pistol_ttt"] = "tss_point_spawner_ammo_pistol",
	["item_ammo_revolver_ttt"] = "tss_point_spawner_ammo_rifle",
	["item_ammo_smg1_ttt"] = "tss_point_spawner_ammo_smg",
	["item_box_buckshot_ttt"] = "tss_point_spawner_ammo_shotgun",
	--hl1d
	["ammo_357"] = "tss_point_spawner_ammo_pistol",
	["ammo_9mmAR"] = "tss_point_spawner_ammo_smg",
	["ammo_9mmbox"] = "tss_point_spawner_ammo_pistol",
	["ammo_9mmclip"] = "tss_point_spawner_ammo_pistol",
	["ammo_ARgrenades"] = "tss_point_spawner_ammo_smg",
	["ammo_buckshot"] = "tss_point_spawner_ammo_shotgun",
	["ammo_crossbow"] = "tss_point_spawner_ammo_sniperrifle",
	["ammo_gaussclip"] = "tss_point_spawner_ammo_smg",
	["ammo_rpgclip"] = "tss_point_spawner_ammo_sniperrifle"}
	--zs
	
local point = {
	["info_player_zombie"] = "tss_point_spawner_npc_zombie_random"}

local object = { --WIP
	["models/props_lab/citizenradio.mdl"] = "tss_object_radio_lab",
	["models/props/cs_italy/radio_wooden.mdl"] = "tss_object_radio_italy",
	["models/props/cs_office/radio.mdl"] = "tss_object_radio_office"}

/*
local item = { --WIP
	["item_healthcharger"] = "tss_object_healthstation",
	["item_suitcharger"] = "tss_object_radio",
	["item_healthkit"] = "tss_item_medkit",
	["item_battery"] = "tss_item_diazepam"}
*/

local item = {}

--functions

function ReplaceObjects()--:GetModel()
	for k, ent in pairs(ents.FindByClass("prop_*")) do
		local oldmodel = ent:GetModel()
		local newclass = object[oldmodel]
		if newclass then
			ReplaceEnt(ent, newclass)
		end
	end
end

function ReplaceItems()
	for k, ent in pairs(ents.FindByClass("item_*")) do
		local oldclass = ent:GetClass() 
		local newclass = item[oldclass]
		if newclass then
			ReplaceEnt(ent, newclass)
		end
	end
end

function ReplaceWeapons()
	for k, ent in pairs(ents.FindByClass("weapon_*")) do
		local oldclass = ent:GetClass() 
		local newclass = weapon[oldclass]
		if newclass then
			ReplaceEnt(ent, newclass)
		end
	end
	for k, ent in pairs(ents.FindByClass("ttt_random_*")) do
		local oldclass = ent:GetClass() 
		local newclass = weapon[oldclass]
		if newclass then
			ReplaceEnt(ent, newclass)
		end
	end
	for k, ent in pairs(ents.FindByClass("item_*")) do
		local oldclass = ent:GetClass() 
		local newclass = weapon[oldclass]
		if newclass then
			ReplaceEnt(ent, newclass)
		end
	end
end

function ReplaceAmmo()
	for k, ent in pairs(ents.FindByClass("item_*")) do
		local oldclass = ent:GetClass() 
		local newclass = ammo[oldclass]
		if newclass then
			ReplaceEnt(ent, newclass)
		end
	end
	for k, ent in pairs(ents.FindByClass("ttt_random_*")) do
		local oldclass = ent:GetClass() 
		local newclass = ammo[oldclass]
		if newclass then
			ReplaceEnt(ent, newclass)
		end
	end
end

function ReplacePoints()
	for k, ent in pairs(ents.FindByClass("ambient_*")) do
		local oldclass = ent:GetClass() 
		local newclass = point[oldclass]
		if newclass then
			ReplaceEnt(ent, newclass)
		end
	end
	for k, ent in pairs(ents.FindByClass("info_*")) do
		local oldclass = ent:GetClass() 
		local newclass = point[oldclass]
		if newclass then
			ReplaceEnt(ent, newclass)
		end
	end
end

function ReplaceEnt(oldent, class)
	if oldent:GetPos() == vector_origin then
		return false
	end
	oldent:SetSolid(SOLID_NONE)
	local newent = ents.Create(class)
	newent:SetPos(oldent:GetPos())
	newent:SetAngles(oldent:GetAngles())
	newent:Spawn()
	newent:Activate()
	newent:PhysWake()
	oldent:Remove()
	return true
end

