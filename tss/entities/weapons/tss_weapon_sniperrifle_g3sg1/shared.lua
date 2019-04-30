
-- Variables that are used on both client and server

SWEP.Base					= "tss_weapon_sniperrifle"
SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= "models/weapons/cstrike/c_snip_g3sg1.mdl"
SWEP.WorldModel				= "models/weapons/w_snip_g3sg1.mdl"

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
SWEP.HoldType				= "crossbow"

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "tss_ammo_sniperrifle"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "G3SG1"			
SWEP.Slot					= 5
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true
SWEP.UseHands				= true

SWEP.DamagePerShot			= 80
SWEP.Accuracy				= 100
SWEP.FireRate				= 4
SWEP.BulletsPerShot			= 1

SWEP.AimTime				= 0.50
SWEP.AimBob					= 0.4
SWEP.AimSway				= 0.4
SWEP.AimFOV					= 65
SWEP.AimPosX				= 7.5
SWEP.AimPosY				= 2.2
SWEP.AimPosZ				= -8
SWEP.AimAngX				= 0 --wip
SWEP.AimAngY				= 0 --wip
SWEP.AimAngZ				= 0 --wip

SWEP.ShootSingleSound		= Sound( "Weapon_SniperRifle.Single" )
SWEP.ShootBurstSound		= Sound( "Weapon_SniperRifle.Burst" )
SWEP.ReloadSound			= Sound( "Weapon_SniperRifle.Reload" )
SWEP.EmptySound				= Sound( "Weapon_Shotgun.Empty" )

function SWEP:Think()
end