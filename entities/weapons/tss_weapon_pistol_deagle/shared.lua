
-- Variables that are used on both client and server

SWEP.Base					= "tss_weapon_pistol"
SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_deagle.mdl"

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

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "tss_ammo_pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "Desert Eagle"			
SWEP.Slot					= 1
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false
SWEP.UseHands				= true

SWEP.DamagePerShot			= 75
SWEP.Accuracy				= 50
SWEP.FireRate				= 4.45
SWEP.BulletsPerShot			= 1

SWEP.AllowAim				= true
SWEP.AimTime				= 0.25
SWEP.AimBob					= 0.4
SWEP.AimSway				= 0.4
SWEP.AimFOV					= 65
SWEP.AimPosX				= 6.39
SWEP.AimPosY				= 1.19
SWEP.AimPosZ				= 0
SWEP.AimAngX				= -2 --wip
SWEP.AimAngY				= 0 --wip
SWEP.AimAngZ				= 0 --wip

SWEP.ShootSingleSound		= Sound( "Weapon_Pistol.Single" )
SWEP.ShootBurstSound		= Sound( "Weapon_Pistol.Burst" )
SWEP.ReloadSound			= Sound( "Weapon_Pistol.Reload" )
SWEP.EmptySound				= Sound( "Weapon_Pistol.Empty" )

function SWEP:Think()	
end