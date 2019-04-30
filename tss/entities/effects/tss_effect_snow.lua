function EFFECT:Init(data)
	self.Particles=data:GetMagnitude()
	self.DieTime=CurTime()+1
	self.Emitter=ParticleEmitter(LocalPlayer():GetPos())
end

local function ParticleCollides(particle, pos, norm)
	if (GetConVar("tss_experimental"):GetBool()) then --WIP
		if (norm.z > 0) then
			util.Decal("splash.large",pos+norm,pos-norm)
		end
	end
	particle:SetDieTime(0)
end

function EFFECT:Think()
	local emitter = self.Emitter
	if (CurTime()>self.DieTime) or (GetGlobalInt( "GlobalWeather", 0 ) != 2) or !(util.IsSkyboxVisibleFromPoint(LocalPlayer():EyePos())) then 
		self.Emitter:Finish()
		return false 
	end
	local speed = 10
	local spawnheight = 192
	for i=1, self.Particles do
		local forward = LocalPlayer():GetForward()
		local right = LocalPlayer():GetRight()
		local spawnpos = LocalPlayer():EyePos() + ((forward - Vector(0,0,forward.z) ) * math.random(-250*((spawnheight-64)/speed),500*((spawnheight-64)/speed))) + ((right - Vector(0,0,right.z) ) * math.random(-250*((spawnheight-64)/speed),250*((spawnheight-64)/speed)))
		local Searching = true
		while Searching do
			local tracedata = {}
					tracedata.start = spawnpos
					tracedata.endpos = spawnpos + Vector(0,0,32768)
			local tr = util.TraceLine(tracedata)
			if tr.AllSolid then
				spawnpos = Vector(0,0,0)
				Searching = false
			elseif tr.HitSky then
				if ((LocalPlayer():EyePos().z + spawnheight) <= tr.HitPos.z ) then
					spawnpos.z = (LocalPlayer():EyePos().z + spawnheight)
				else
					spawnpos = tr.HitPos
				end
				Searching = false
			elseif tr.HitWorld then
				spawnpos = Vector(0,0,0)
				Searching = false
			elseif ( 32768<= tr.HitPos.z ) then
				spawnpos = Vector(0,0,0)
				Searching = false
			else
				spawnpos = tracedata.endpos
			end
		end
		if (spawnpos != Vector(0,0,0)) then
			local tracedata = {}
				tracedata.start = spawnpos
				tracedata.endpos = spawnpos + Vector(0,0,-32768)
				tracedata.mask = MASK_SOLID + CONTENTS_WATER
			local tr = util.TraceLine(tracedata)
			local distance = spawnpos:Distance(tr.HitPos)
			local wind = GetGlobalVector( "GlobalWind", Vector(0,0,0))
			local particle = emitter:Add("effects/rain_cloud", spawnpos)
			if (particle) and (tr.Hit) then
				particle:SetVelocity(Vector(0,0,-speed) + wind)
				particle:SetDieTime((distance)/speed)
				particle:SetStartAlpha(0)
				particle:SetEndAlpha(128)
				particle:SetStartSize(0)
				particle:SetEndSize(4)
				particle:SetAirResistance(0)
				particle:SetLighting( false )
				particle:SetCollide(true)
				particle:SetBounce(0.1)
				particle:SetCollideCallback(ParticleCollides)
				particle:SetGravity( Vector( 0, 0, 0 ) )
			end
		end
	end
	return true
end

function EFFECT:Render()

end