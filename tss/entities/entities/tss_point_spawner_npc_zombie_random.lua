
AddCSLuaFile()

ENT.Base 		= "tss_point_spawner_npc_base"
ENT.Squad 		= "Zombie"

function ENT:Think()
	local ent = self:GetNWEntity( "npc", NULL )
	if !(IsValid(ent)) then
		if (self:GetNWInt( "time", 0 ) == 0) then
			self:SetNWInt( "time", CurTime()+math.random( self.SpawnMin, self.SpawnMax ) )
		else
			if (self:GetNWInt( "time", CurTime() ) < CurTime()) then
				local npc = {
					"npc_zombie",
					"npc_fastzombie"}
				ent = ents.Create(table.Random(npc))
				ent:SetKeyValue( "squadname", self.Squad)
				ent:SetPos(self:GetPos())
				ent:SetAngles(self:GetAngles())
				ent:Spawn()
				ent:Activate()
				ent:PhysWake()
				self:SetNWEntity( "npc", ent )
				self:SetNWInt( "time", 0 )
			end
		end
	end
end