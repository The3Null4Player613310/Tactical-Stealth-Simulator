
-- Variables that are used on both client and server

SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= Model("models/weapons/c_arms.mdl")
SWEP.WorldModel				= ""

SWEP.ViewModelFlip			= false
SWEP.ViewModelFlip1			= false
SWEP.ViewModelFlip2			= false
SWEP.HoldType				= "fist"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "Fists"
SWEP.Slot					= 0
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= false
SWEP.UseHands				= true

SWEP.ViewModelFOV			= 54
SWEP.HitDistance			= 48

local SwingSound = Sound("WeaponFrag.Throw")
local HitSound = Sound("Flesh.ImpactHard")
local WaitTime = 0

function SWEP:Initialize()
	self:SetHoldType("normal")
	--self:SetHoldType("fist")
end

function SWEP:Reload()
	if ( CurTime() > WaitTime ) then
		local vm = self.Owner:GetViewModel()
		if (self:GetNWBool("Armed",false)) then
			self:SetNWBool("Armed",false)
			self:SetHoldType("normal")
			vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_holster"))
			self:UpdateNextIdle()
		else
			self:SetNWBool("Armed",true)
			self:SetHoldType("fist")
			vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_draw"))
			self:UpdateNextIdle()
		end
		WaitTime = CurTime()+vm:SequenceDuration()
		self:SetNextPrimaryFire(CurTime()+vm:SequenceDuration())
		self:SetNextSecondaryFire(CurTime()+vm:SequenceDuration())
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextMeleeAttack")
	self:NetworkVar("Float", 1, "NextIdle")
	self:NetworkVar("Int", 2, "Combo")
end

function SWEP:UpdateNextIdle()
	local vm = self.Owner:GetViewModel()
	self:SetNextIdle(CurTime()+vm:SequenceDuration())
end

function SWEP:PrimaryAttack(right)
	if (self:GetNWBool("Armed",false)) then
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		local anim = "fists_left"
		if (right) then
			anim = "fists_right"
		end
		if (self:GetCombo() >= 2) then
			anim = "fists_uppercut"
		end
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
		self:EmitSound(SwingSound)
		self:UpdateNextIdle()
		self:SetNextMeleeAttack(CurTime()+0.2)
		self:SetNextPrimaryFire(CurTime()+0.9)
		self:SetNextSecondaryFire(CurTime()+0.9)
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack(true)
end

function SWEP:DealDamage()
	local anim = self:GetSequenceName(self.Owner:GetViewModel():GetSequence())
	self.Owner:LagCompensation(true)
	local tr = util.TraceLine({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos()+self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	})
	if (!IsValid(tr.Entity)) then 
		tr = util.TraceHull({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos()+self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector(-10, -10, -8),
			maxs = Vector(10, 10, 8),
			mask = MASK_SHOT_HULL
		})
	end
	-- We need the second part for single player because SWEP:Think is ran shared in SP
	if (tr.Hit && !(game.SinglePlayer() && CLIENT)) then
		self:EmitSound(HitSound)
	end
	local hit = false
	if (SERVER && IsValid(tr.Entity) && (tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0)) then
		local dmginfo = DamageInfo()
		local attacker = self.Owner
		if (!IsValid(attacker)) then
			attacker = self 
		end
		dmginfo:SetAttacker(attacker)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(math.random(8, 12))
		if (anim == "fists_left") then
			dmginfo:SetDamageForce(self.Owner:GetRight() * 4912+self.Owner:GetForward() * 9998) -- Yes we need those specific numbers
		elseif (anim == "fists_right") then
			dmginfo:SetDamageForce(self.Owner:GetRight() * -4912+self.Owner:GetForward() * 9989)
		elseif (anim == "fists_uppercut") then
			dmginfo:SetDamageForce(self.Owner:GetUp() * 5158+self.Owner:GetForward() * 10012)
			dmginfo:SetDamage(math.random(12, 24))
		end
		tr.Entity:TakeDamageInfo(dmginfo)
		hit = true
	end
	if (SERVER && IsValid(tr.Entity)) then
		local phys = tr.Entity:GetPhysicsObject()
		if (IsValid(phys)) then
			phys:ApplyForceOffset(self.Owner:GetAimVector() * 80 * phys:GetMass(), tr.HitPos)
		end
	end
	if (SERVER) then
		if (hit && anim != "fists_uppercut") then
			self:SetCombo(self:GetCombo()+1)
		else
			self:SetCombo(0)
		end
	end
	self.Owner:LagCompensation(false)
end

function SWEP:OnDrop()
	self:Remove() -- You can't drop fists
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	if (self:GetNWBool("Armed",false)) then
		vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_draw"))
	end
	self:UpdateNextIdle()
	if (SERVER) then
		self:SetCombo(0)
	end
	return true

end

function SWEP:Think()
	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()
	if (idletime > 0 && CurTime() > idletime) then
		if (self:GetNWBool("Armed",false)) then
			vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_idle_0" .. math.random(1, 2)))
		end
		self:UpdateNextIdle()
	end
	local meleetime = self:GetNextMeleeAttack()
	if (meleetime > 0 && CurTime() > meleetime) then
		self:DealDamage()
		self:SetNextMeleeAttack(0)
	end
	if (SERVER && CurTime() > self:GetNextPrimaryFire()+0.1) then
		self:SetCombo(0)
	end
end