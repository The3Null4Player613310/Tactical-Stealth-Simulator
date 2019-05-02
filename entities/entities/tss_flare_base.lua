AddCSLuaFile()

ENT.Type = "anim"
ENT.Model = Model("models/props_c17/trappropeller_lever.mdl")
ENT.Color = Color(50,50,50) --white(50,50,50) red(50,0,0) green(0,50,0) blue(0,0,50) gold(50,25,0) yellow(50,50,0) magenta(50,0,50) cyan(0,50,50)
ENT.Explode = Sound( "weapons/flashbang/flashbang_explode1.wav" )
ENT.Burn = Sound( "Weapon_FlareGun.Burn" )
ENT.Ignited = false
ENT.SmokeTick = 0
ENT.Emitter = nil

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	if IsValid( phys ) then
		phys:Wake()
		phys:SetDamping( 0, 10 )
	end
end

function ENT:Think()
	local Itime = self:GetNWFloat( "IgniteTime", -1 )
	local Etime = self:GetNWFloat( "ExtinguishTime", 0 )
	if ((Itime != 0) and (Itime < CurTime())) then
		if SERVER then
			self:SetNWFloat( "IgniteTime", 0 )
			if Etime == 0 then
				self:SetNWFloat( "ExtinguishTime", CurTime()+15 )
			elseif Etime == -1 then
				self:SetNWFloat( "ExtinguishTime", 0 )
			end
			self:EmitSound( self.Burn )
			self:EmitSound( self.Explode, 100, math.random(90,110) )
		else
			self.Emitter = ParticleEmitter( self:GetPos(), false )
		end
	elseif ((Etime != 0) and (Etime < CurTime())) then
		if SERVER then
			self:StopSound( self.Burn )
			self:Remove()
		else
			if self.Emitter then
				self.Emitter:Finish()
				self.Emitter = nil
			end
		end
	elseif ((Itime < CurTime()) and (Etime > CurTime())) then
		if SERVER then
		else
			local lightval = math.random( 100, 150 )
			--light code
			local dlight = DynamicLight( self.Entity:EntIndex() )
			if dlight then
				dlight.Pos = self:GetPos() + self:GetRight() * 5
				dlight.r = self.Color.r
				dlight.g = self.Color.g
				dlight.b = self.Color.b
				dlight.Brightness = 3
				dlight.Decay = 2048
				dlight.size = 256 * ((lightval-50)/100)
				dlight.DieTime = CurTime() + 1
			end
			--smoke code
			if self.SmokeTick < CurTime() then
				self.SmokeTick = CurTime() + 0.1
				if (self:WaterLevel() > 2) then
					local speed = 64
					local distance = 128
					local tracedata = {}
						tracedata.start = self:GetPos()
						tracedata.endpos = self:GetPos() + Vector(0,0,distance)
						tracedata.mask = CONTENTS_WATER
					local tr = util.TraceLine(tracedata)
					print(tr.AllSolid)
					print(tr.FractionLeftSolid)
					local particle = self.Emitter:Add( "effects/bubble", self:GetPos() + self:GetRight() * 5 )
					if particle then
						particle:SetVelocity( Vector( math.random( -1, 1), math.random( -1, 1 ), 0) + Vector( 0, 0, speed))
						if tr.AllSolid then
							particle:SetDieTime( distance / speed )
						else
							particle:SetDieTime( distance * tr.FractionLeftSolid / speed )
						end
						particle:SetStartAlpha( 100 )
						particle:SetEndAlpha( 0 )
						particle:SetStartSize( math.random( 0, 0 ) )
						particle:SetEndSize( math.random( 4, 6 ) )
						particle:SetGravity( Vector( 0, 0, 0 ) )
						particle:SetAirResistance(0)
						particle:SetLighting( false )
						particle:SetCollide( true )
						particle:SetBounce( 1 )
						particle:SetColor( 255, 255, 255)
					end
				else
					local particle = self.Emitter:Add( "particles/smokey", self:GetPos() + self:GetRight() * 5 )
					local wind = GetGlobalVector( "GlobalWind", Vector(0,0,0))
					if particle then
						particle:SetVelocity( (VectorRand() * 5) + Vector(0,0,10) + wind) --add to weather + GlobalWindVector
						particle:SetDieTime( math.Rand( 2.5, 5.0 ) )
						particle:SetStartAlpha( 100 )
						particle:SetEndAlpha( 0 )
						particle:SetStartSize( math.random( 3, 6 ) )
						particle:SetEndSize( math.random( 25, 50 ) )
						particle:SetGravity( Vector( 0, 0, math.random( 9, 11 ) ) )
						particle:SetAirResistance(0)
						particle:SetLighting( false )
						particle:SetCollide( true )
						particle:SetBounce( 1 )
						particle:SetColor( math.Clamp(lightval+self.Color.r,0,255), math.Clamp(lightval+self.Color.g,0,255), math.Clamp(lightval+self.Color.b,0,255))
					end
				end
			end
		end
	end
end
function ENT:SetIgnite(Itime)
	if SERVER then
		self:SetNWFloat( "IgniteTime", Itime )
	end
end

function ENT:SetExtinguish(Etime)
	if SERVER then
		self:SetNWFloat( "ExtinguishTime", Etime )
	end
end