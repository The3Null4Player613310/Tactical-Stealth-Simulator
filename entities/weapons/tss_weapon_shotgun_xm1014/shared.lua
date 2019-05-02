
-- Variables that are used on both client and server

SWEP.Base					= "tss_weapon_shotgun"
SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel				= "models/weapons/w_shot_xm1014.mdl"

SWEP.ViewModelFlip			= false
SWEP.ViewModelFlip1			= false
SWEP.ViewModelFlip2			= false
if IsMounted( "cstrike" ) then
	SWEP.CSMuzzleFlashes		= true
	SWEP.CSMuzzleX				= true
else
	SWEP.CSMuzzleFlashes		= false
	SWEP.CSMuzzleX				= false
end
SWEP.HoldType				= "shotgun"

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "tss_ammo_shotgun"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "XM1014"		
SWEP.Slot					= 3
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true
SWEP.UseHands				= true

SWEP.DamagePerShot			= 100
SWEP.Accuracy				= 15
SWEP.FireRate				= 6.67
SWEP.BulletsPerShot			= 10

SWEP.AllowAim				= true
SWEP.AimTime				= 0.25
SWEP.AimBob					= 0.4 --wont work for some reason
SWEP.AimSway				= 0.2 --same
SWEP.AimFOV					= 65
SWEP.AimPosX				= 6.80
SWEP.AimPosY				= 4.1
SWEP.AimPosZ				= -3
SWEP.AimAngX				= 5 --wip
SWEP.AimAngY				= 0 --wip
SWEP.AimAngZ				= 0 --wip

SWEP.ShootSingleSound		= Sound( "Weapon_Shotgun.Single" )
SWEP.ShootBurstSound		= Sound( "Weapon_Shotgun.Burst" )
SWEP.ReloadSound			= Sound( "Weapon_Shotgun.Reload" )
SWEP.EmptySound				= Sound( "Weapon_Shotgun.Empty" )

function SWEP:Think()
end