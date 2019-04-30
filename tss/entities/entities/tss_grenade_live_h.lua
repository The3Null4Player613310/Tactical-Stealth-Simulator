AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "tss_grenade_live_base"
ENT.Model = Model("models/weapons/w_eq_fraggrenade_thrown.mdl")
ENT.Radius = 0
ENT.Magnitude = 133
ENT.Exploded = false

function ENT:Explode(tr)
	if SERVER then
		self:SetNoDraw(true)
		self:SetSolid(SOLID_NONE)
		if tr.Fraction != 1.0 then
			self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
		end
		local pos = self:GetPos()
		local explosion = ents.Create("env_explosion")
		if IsValid(explosion) then
			explosion:SetPos(pos)
			explosion:SetKeyValue("iMagnitude", self.Magnitude)
			explosion:SetKeyValue("iRadiusOverride", self.Radius)
			explosion:Spawn()
			explosion:Fire("Explode", "", 0)
			explosion:Fire( "Kill", "", 0 );
		end
		
		local physexplosion = ents.Create("env_physexplosion")
		if IsValid(physexplosion) then
			physexplosion:SetPos(pos)
			physexplosion:SetKeyValue("magnitude", math.Clamp( self.Magnitude, 0, 100))
			physexplosion:SetKeyValue("radius", self.Radius)
			physexplosion:SetKeyValue("spawnflags", 2) --16
			physexplosion:Spawn()
			physexplosion:Fire("Explode", "", 0)
			explosion:Fire( "Kill", "", 0 );
		end
	end
	self.Exploded = true
end