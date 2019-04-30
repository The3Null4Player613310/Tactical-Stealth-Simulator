
-- Variables that are used on both client and server

SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel				= "models/weapons/w_eq_fraggrenade.mdl"

SWEP.ViewModelFlip			= false
SWEP.ViewModelFlip1			= true
SWEP.ViewModelFlip2			= false
SWEP.CSMuzzleFlashes		= false
SWEP.CSMuzzleX				= false
SWEP.HoldType				= "grenade"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "Grenade"			
SWEP.Slot					= 3
SWEP.SlotPos				= 2
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false
SWEP.UseHands				= true

SWEP.Grenade				= "tss_grenade_live_h"

local ShootSingleSound = Sound( "Weapon_Pistol.Single" )
local ShootBurstSound = Sound( "Weapon_Pistol.Burst" )
local ReloadSound = Sound( "Weapon_Pistol.Reload" )
local EmptySound = Sound( "Weapon_Pistol.Empty" )

local fuse = 0


function SWEP:Initialize()
	
	fuse = math.random(3,5) --fuses can vary in length in the battlefield not advised to cook
	self:SetHoldType( self.HoldType )
	
end

function SWEP:Reload() --WIP
end

function SWEP:Think()	
end

function SWEP:PrimaryAttack()

	self:Throw()
	
end

function SWEP:SecondaryAttack()
end

function SWEP:Deploy() --WIP

	return true
	
end

function SWEP:ShouldDropOnDie()

	return true

end

function SWEP:Throw()
	if SERVER then
		local ply = self.Owner
		if not IsValid(ply) then 
			return 
		end
		local ang = ply:EyeAngles()
		local src = ply:GetPos() + (ply:Crouching() and ply:GetViewOffsetDucked() or ply:GetViewOffset())+ (ang:Forward() * 8) + (ang:Right() * 10)
		local target = ply:GetEyeTraceNoCursor().HitPos
		local tang = (target-src):Angle()
		if tang.p < 90 then
			tang.p = -10 + tang.p * (10/9)
		else
			tang.p = 360 - tang.p
			tang.p = -10 + tang.p * -(10/9)
		end
		tang.p=math.Clamp(tang.p,-90,90)
		local vel = math.min(800, (90 - tang.p) * 6)
		local thr = tang:Forward() * vel + ply:GetVelocity()
		self:CreateGrenade(src, Angle(0,0,0), thr, Vector(600, math.random(-1200, 1200), 0), ply)
		ply:SelectWeapon( "tss_weapon_fists" )
		self:Remove()
	end
end

function SWEP:CreateGrenade(src, ang, vel, angimp, ply)
	local gren = ents.Create(self.Grenade)
	if not IsValid(gren) then 
		return 
	end
	gren:SetPos(src)
	gren:SetAngles(ang)
	gren:SetOwner(ply)
	gren:SetGravity(0.4)
	gren:SetFriction(0.2)
	gren:SetElasticity(0.45)
	gren:Spawn()
	gren:PhysWake()
	local phys = gren:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(vel)
		phys:AddAngleVelocity(angimp)
	end
	gren:SetDetonation(CurTime() + fuse)
return gren
end