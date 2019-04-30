--tss npc spawner base

AddCSLuaFile()

ENT.Type 		= "point"
ENT.Base 		= "base_point"
ENT.NPCType 	= "npc_citizen"
ENT.Squad 		= "Default"
ENT.SpawnMin 	= 30
ENT.SpawnMax 	= 300

function ENT:Initialize()
	self:SetNWInt( "time", -1)
end

function ENT:Think()
	local ent = self:GetNWEntity( "npc", NULL )
	if !(IsValid(ent)) then
		if (self:GetNWInt( "time", 0 ) == 0) then
			self:SetNWInt( "time", CurTime()+math.random( self.SpawnMin, self.SpawnMax ) )
		else
			if (self:GetNWInt( "time", CurTime() ) < CurTime()) then
				ent = ents.Create(self.NPCType)
				ent:SetKeyValue( "squadname", self.Squad)
				ent:SetPos(self:GetPos()+Vector(0,0,10))
				ent:SetAngles(self:GetAngles())
				ent:Spawn()
				ent:DropToFloor()
				ent:Activate()
				ent:PhysWake()
				self:SetNWEntity( "npc", ent )
				self:SetNWInt( "time", 0 )
			end
		end
	end
end