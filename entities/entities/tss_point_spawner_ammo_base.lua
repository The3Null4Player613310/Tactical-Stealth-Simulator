--tss ammo spawner base

AddCSLuaFile()

ENT.Type				= "point"
ENT.Base				= "base_point"
ENT.AmmoType			= "tss_ammo_pistol"
ENT.Ammo				= "tss_ammo_pistol"
ENT.SpawnMin			= 30
ENT.SpawnMax			= 300
ENT.NextThinkTimeDelay	= 15
ENT.NextThinkTime		= 0

function ENT:Initialize()
	self:SetNWInt( "time", -1)
end

function ENT:Think()
	local ent = self:GetNWEntity( "ammo", NULL )
	if !(IsValid(ent)) then
		if (self:GetNWInt( "time", 0 ) == 0) then
			self:SetNWInt( "time", CurTime()+math.random( self.SpawnMin, self.SpawnMax ) )
		else
			if (self:GetNWInt( "time", CurTime() ) < CurTime()) then
				if (self.AmmoType == "random") then
					local ammo = {
						"tss_ammo_pistol",
						"tss_ammo_smg",
						"tss_ammo_shotgun",
						"tss_ammo_rifle",
						"tss_ammo_sniperrifle"}
					self.Ammo = table.Random(ammo)
				else
						self.Ammo = self.AmmoType
				end
				ent = ents.Create(self.Ammo)
				ent:SetPos(self:GetPos())
				ent:SetAngles(self:GetAngles())
				ent:Spawn()
				ent:Activate()
				ent:PhysWake()
				self:SetNWEntity( "ammo", ent )
				self:SetNWInt( "time", 0 )
			end
		end
	end
end