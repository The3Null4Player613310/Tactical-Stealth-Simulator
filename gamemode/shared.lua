--Author info
GM.Name = "Tactical Stealth Simulator"
GM.Author = "TheNullPlayer"
GM.Email = "N/A"
GM.Website = "N/A"

--Derive From Base
DeriveGamemode("base")

--setup teams
team.SetUp( 1, "Lobby",  Color( 100, 100, 100 ), true)
team.SetUp( 2, "CounterTerrorists",  Color( 0, 255, 0 ), false)
team.SetUp( 3, "Terrorists",  Color( 255, 0, 0 ), true)
team.SetUp( 4, "Hostages",  Color( 0, 0, 255 ), false)

--setup ammo
game.AddAmmoType( 
		{
			name		=	"tss_ammo_pistol",
			dmgtype		=	DMG_BULLET,
			tracer		=	TRACER_LINE_AND_WHIZ,
			plydmg		=	10,
			npcdmg		=	10,
			force		=	1000,
			minsplash	=	0,
			maxsplash	=	0
})

game.AddAmmoType( 
		{
			name		=	"tss_ammo_smg",
			dmgtype		=	DMG_BULLET,
			tracer		=	TRACER_LINE_AND_WHIZ,
			plydmg		=	10,
			npcdmg		=	10,
			force		=	1000,
			minsplash	=	0,
			maxsplash	=	0
})

game.AddAmmoType( 
		{
			name		=	"tss_ammo_shotgun",
			dmgtype		=	DMG_BULLET,
			tracer		=	TRACER_LINE_AND_WHIZ,
			plydmg		=	10,
			npcdmg		=	10,
			force		=	1000,
			minsplash	=	0,
			maxsplash	=	0
})

game.AddAmmoType( 
		{
			name		=	"tss_ammo_rifle",
			dmgtype		=	DMG_BULLET,
			tracer		=	TRACER_LINE_AND_WHIZ,
			plydmg		=	10,
			npcdmg		=	10,
			force		=	1000,
			minsplash	=	0,
			maxsplash	=	0
})

game.AddAmmoType( 
		{
			name		=	"tss_ammo_sniperrifle",
			dmgtype		=	DMG_BULLET,
			tracer		=	TRACER_LINE_AND_WHIZ,
			plydmg		=	10,
			npcdmg		=	10,
			force		=	1000,
			minsplash	=	0,
			maxsplash	=	0
})

--set convars
RunConsoleCommand("sv_allowcslua","0")
--RunConsoleCommand("sv_alltalk","2")
RunConsoleCommand("player_limit_jump_speed","0")
RunConsoleCommand("mp_show_voice_icons","0")
RunConsoleCommand("mp_falldamage","1")
RunConsoleCommand("mp_friendlyfire","1")
RunConsoleCommand("npc_citizen_auto_player_squad","0")
RunConsoleCommand("npc_citizen_auto_player_squad_allow_use","1")
RunConsoleCommand("mat_specular","0")

--Hooks

--noclip
function GM:PlayerNoClip(ply,desiredState)
	if (desiredState == false) then -- the player wants to turn noclip off
		return true -- always allow
	elseif ( GetConVar("tss_noclip"):GetBool() == true ) then
		return true -- allow if tss_noclip is enabled
	end
	return false
end

--Functions

function GM:Initialize()
	-- Do stuff
end

--Decide if the player is crouching if so move quietly
function GM:PlayerFootstep(ply,pos,foot,sound,volume,filter)
	return ply:Crouching()
end

--DEBUG

--Show Mounted Content
--PrintTable( engine.GetGames() )