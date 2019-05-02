AddCSLuaFile()

ENT.Type = "anim"
ENT.Model = Model("models/weapons/w_eq_fraggrenade_thrown.mdl")
ENT.Radius = 0
ENT.Magnitude = 0
ENT.Exploded = false

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
end

function ENT:Think()
	if self.Exploded and SERVER then --WIP note to self change self.exploded to nw var for fix
		self:Remove()
		return
	end
	local dtime = self:GetNWFloat( "DetonationTime", 0 )
	if dtime != 0 and dtime < CurTime() then
		local pos = self:GetPos()
		local tr = util.TraceLine({start=pos, endpos=pos + Vector(0,0,-32), mask=MASK_SHOT_HULL, filter=self.thrower})
		self:Explode(tr)
	end
end

function ENT:SetDetonation(Dtime)
	if SERVER then
		self:SetNWFloat( "DetonationTime", Dtime )
	end
end

function ENT:Explode(tr)
	print("BOOM!")
end