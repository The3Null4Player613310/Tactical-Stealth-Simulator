
-- Variables that are used on both client and server

SWEP.Base					= "tss_weapon_rifle"
SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_aug.mdl"

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
SWEP.HoldType				= "ar2"

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "tss_ammo_rifle"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "AUG"			
SWEP.Slot					= 4
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true
SWEP.UseHands				= true

SWEP.DamagePerShot			= 63.5
SWEP.Accuracy				= 50
SWEP.FireRate				= 11.1
SWEP.BulletsPerShot			= 1

SWEP.AllowAim				= false
SWEP.AimTime				= 0.25
SWEP.AimBob					= 0.5
SWEP.AimSway				= 0.6
SWEP.AimFOV					= 45
SWEP.AimPosX				= 0
SWEP.AimPosY				= 2.5
SWEP.AimPosZ				= -26
SWEP.AimAngX				= 0 --wip
SWEP.AimAngY				= 0 --wip
SWEP.AimAngZ				= 0 --wip

SWEP.ShootSingleSound		= Sound( "Weapon_SMG1.Single" )
SWEP.ShootBurstSound		= Sound( "Weapon_SMG1.Burst" )
SWEP.ReloadSound			= Sound( "Weapon_pistol.Reload" )
SWEP.EmptySound				= Sound( "Weapon_Shotgun.Empty" )

function SWEP:Think()
end