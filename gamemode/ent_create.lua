
--varibles

local points = {
	--dod
	--css
	"func_buyzone",
	"func_bomb_target",
	--tf2
	"team_control_point",
	"item_ammopack_small",
	"item_ammopack_medium",
	"item_ammopack_full",
	"item_healthkit_small",
	"item_healthkit_medium",
	"item_healthkit_full",
	--ttt
	"ttt_random_weapon",
	"ttt_random_ammo",
	"item_ammo_357_ttt",
	"item_ammo_pistol_ttt",
	"item_ammo_revolver_ttt",
	"item_ammo_smg1_ttt",
	"item_box_buckshot_ttt",
	"weapon_zm_molotov",
	"weapon_ttt_smokegrenade",
	"weapon_ttt_confgrenade",
	"weapon_zm_sledge",
	"weapon_zm_pistol",
	"weapon_ttt_glock",
	"weapon_zm_revolver",
	"weapon_zm_mac10",
	"weapon_zm_shotgun",
	"weapon_ttt_m16",
	"weapon_zm_rifle",
	--zs
	"info_player_redeemed",
	"logic_waves",
	"logic_waveend",
	"zombiegasses",
	"weapon_zs_resupplybox",
	"weapon_zs_arsenalcrate",
	"weapon_zs_fryingpan",
	"weapon_zs_hammer",
	"weapon_zs_mp5",
	"weapon_zs_deagle",
	"weapon_zs_tosser",
	"weapon_zs_blaster",
	"weapon_zs_eraser",
	"weapon_zs_reaper",
	"weapon_zs_ender",
	"weapon_zs_pulserifle"}


for k, v in pairs(points) do --create dummy ents
   scripted_ents.Register({Type="point", IsWeaponDummy=true}, v, false)
end

--functions

function CreatePoints()
	CreatePointEnt(Vector(0,0,0), "tss_point_radio_tower")
end

function CreatePointEnt(pos,class)
	local newent = ents.Create(class)
	newent:SetPos(pos)
	newent:Spawn()
	newent:Activate()
	return newent
end

