AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "tss_grenade_live_base"
ENT.Model = Model("models/weapons/w_eq_flashbang_thrown.mdl")
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
		local Players = player.GetAll()
		for id=1,#Players do
			local disvec = self:GetPos()-Players[id]:EyePos()
			local dis = math.sqrt((disvec.x*disvec.x)+(disvec.y*disvec.y)+(disvec.z*disvec.z))
			if Players[id]:Alive() then
				if Players[id]:TestPVS( self ) then
					if (Players[id]:Visible( self )) then
						if (dis<1000) then
							local entang = (self:GetPos()-Players[id]:GetPos()):Angle() --WIP
							local plyang = Players[id]:EyeAngles()
							local plyfov
							if Players[id]:IsBot() then
								plyfov = Players[id]:GetFOV()
							else
								plyfov = 180
							end
							entang:Normalize()
							local yawdiff = math.abs(math.AngleDifference(entang.y,plyang.y))
							if (yawdiff <= (plyfov/2)) then --add buffer of 10 degrees for wide screen
								stun = (1/(dis*(1.22/64)))
								print("hit")
							else
								stun = (0.125/(dis*(1.22/64)))
								print("miss")
							end
							print((plyfov/2))
							print(yawdiff)
							print(stun)
							Players[id]:SetNWInt( "stunval", (-1*stun))
							timer.Simple( (5*stun), function() Players[id]:SetNWInt( "stunval", 0) end ) --WIP can be fixed with advanced timers
						end
					end
				end
				if dis < 600 then
					Players[id]:SetDSP( 35 , false )
				elseif dis < 800 then
					Players[id]:SetDSP( 36 , false )
				elseif dis < 1000 then
					Players[id]:SetDSP( 37 , false )
				else
					self:EmitSound("BaseExplosionEffect.Sound", CHAN_WEAPON)
				end
			end
		end	
	else
		local spos = self:GetPos()
		local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-128), filter=self})
		util.Decal("SmallScorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)      
		if tr.Fraction != 1.0 then
			spos = tr.HitPos + tr.HitNormal * 0.6
		end
	end
	local effectdata = EffectData()
	effectdata:SetOrigin( self:GetPos() )
	effectdata:SetMaterialIndex( self:EntIndex() )
	util.Effect( "tss_effect_flashbang" , effectdata )
	self.Exploded = true
end
