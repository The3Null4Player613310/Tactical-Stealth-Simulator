
-- Variables that are used on both client and server

SWEP.Base					= "tss_weapon_pistol"
SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_p228.mdl"

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
SWEP.HoldType				= "pistol"

SWEP.Primary.ClipSize		= 13
SWEP.Primary.DefaultClip	= 13
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "tss_ammo_pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "P228"			
SWEP.Slot					= 1
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false
SWEP.UseHands				= true

SWEP.DamagePerShot			= 50
SWEP.Accuracy				= 50
SWEP.FireRate				= 6.66
SWEP.BulletsPerShot			= 1

SWEP.AllowAim				= true
SWEP.AimTime				= 0.25
SWEP.AimBob					= 0.4
SWEP.AimSway				= 0.4
SWEP.AimFOV					= 65
SWEP.AimPosX				= 6
SWEP.AimPosY				= 2.8
SWEP.AimPosZ				= 0
SWEP.AimAngX				= 0 --wip
SWEP.AimAngY				= 0 --wip
SWEP.AimAngZ				= 0 --wip

SWEP.ShootSingleSound		= Sound( "Weapon_Pistol.Single" )
SWEP.ShootBurstSound		= Sound( "Weapon_Pistol.Burst" )
SWEP.ReloadSound			= Sound( "Weapon_Pistol.Reload" )
SWEP.EmptySound				= Sound( "Weapon_Pistol.Empty" )

function SWEP:Think()	
end