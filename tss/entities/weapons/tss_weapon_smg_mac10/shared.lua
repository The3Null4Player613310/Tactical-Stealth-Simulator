
-- Variables that are used on both client and server

SWEP.Base					= "tss_weapon_smg"
SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_mac10.mdl"

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
SWEP.HoldType				= "smg"

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "tss_ammo_smg"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "MAC10"			
SWEP.Slot					= 2
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= false
SWEP.UseHands				= true

SWEP.DamagePerShot			= 25
SWEP.Accuracy				= 20
SWEP.FireRate				= 15
SWEP.BulletsPerShot			= 1

SWEP.ShootSingleSound		= Sound( "Weapon_SMG1.Single" )
SWEP.ShootBurstSound		= Sound( "Weapon_SMG1.Burst" )
SWEP.ReloadSound			= Sound( "Weapon_SMG1.Reload" )
SWEP.EmptySound				= Sound( "Weapon_SMG1.Empty" )

function SWEP:Think()
end