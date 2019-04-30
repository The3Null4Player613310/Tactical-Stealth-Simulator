
-- Variables that are used on both client and server

SWEP.Base					= "tss_weapon_base_gun"
SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= "models/weapons/c_shotgun.mdl"
SWEP.WorldModel				= "models/weapons/w_shotgun.mdl"

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

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "tss_ammo_shotgun"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "Shotgun"		
SWEP.Slot					= 3
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= false
SWEP.UseHands				= true

SWEP.DamagePerShot			= 100
SWEP.Accuracy				= 15
SWEP.FireRate				= 2
SWEP.BulletsPerShot			= 10

SWEP.AllowAim				= true
SWEP.AimTime				= 0.25
SWEP.AimBob					= 0.4
SWEP.AimSway				= 0.2
SWEP.AimFOV					= 65
SWEP.AimPosX				= 9
SWEP.AimPosY				= 4.25
SWEP.AimPosZ				= -6
SWEP.AimAngX				= 0 --wip
SWEP.AimAngY				= 0 --wip
SWEP.AimAngZ				= 0 --wip

SWEP.ShootSingleSound		= Sound( "Weapon_Shotgun.Single" )
SWEP.ShootBurstSound		= Sound( "Weapon_Shotgun.Burst" )
SWEP.ReloadSound			= Sound( "Weapon_Shotgun.Reload" )
SWEP.EmptySound				= Sound( "Weapon_Shotgun.Empty" )

function SWEP:Think()
end