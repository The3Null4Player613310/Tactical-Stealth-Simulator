AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "tss_grenade_live_base"
ENT.Model = Model("models/weapons/w_eq_smokegrenade_thrown.mdl")
ENT.Radius = 20
ENT.Magnitude = 0
ENT.Exploded = false

function ENT:Explode(tr)
	if SERVER then
		self:SetNoDraw(true)
		self:SetSolid(SOLID_NONE)
		if tr.Fraction != 1.0 then
			self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
		end
	else
		local spos = self:GetPos()
		local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-128), filter=self})
		util.Decal("SmallScorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)      
		if tr.Fraction != 1.0 then
			spos = tr.HitPos + tr.HitNormal * 0.6
		end
		self:CreateSmoke(spos)
	end
	self.Exploded = true
end


local smokeparticles = {
	Model("particle/particle_smokegrenade"),
	Model("particle/particle_noisesphere")
};

function ENT:CreateSmoke(center)
	local em = ParticleEmitter(center)
	local r = self.Radius
	for i=1, 5 do
		local prpos = VectorRand() * r
		prpos.z = prpos.z + 32
		local particle = em:Add(table.Random(smokeparticles), center + prpos)
		if particle then
			local gray = math.random(75, 200)
			particle:SetColor(gray, gray, gray)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(200)
			particle:SetVelocity(VectorRand() * math.Rand(900, 1300))
			particle:SetLifeTime(0)
			particle:SetDieTime(math.Rand(50, 70))
			particle:SetStartSize(math.random(140, 150))
			particle:SetEndSize(math.random(1, 40))
			particle:SetRoll(math.random(-180, 180))
			particle:SetRollDelta(math.Rand(-0.1, 0.1))
			particle:SetAirResistance(600)
			particle:SetCollide(true)
			particle:SetBounce(0.4)
			particle:SetLighting(false)
		end
	end
	em:Finish()
end