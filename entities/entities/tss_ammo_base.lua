--tss ammo base

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

-- override these values
ENT.AmmoType = "Pistol"
ENT.AmmoAmount = 1
ENT.AmmoMax = 10
ENT.Model = Model("models/items/boxsrounds.mdl")

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
	self.taken = false
end

function ENT:Use(ply) --WIP
	if SERVER and self.taken != true then
		if (ply:IsValid() and ply:IsPlayer()) then
			if (ply:Alive()) then
				local ammo = ply:GetAmmoCount(self.AmmoType)
				if self.AmmoMax >= (ammo + math.ceil(self.AmmoAmount * 0.25)) then -- need clipmax info and room for at least 1/4th
					local given = self.AmmoAmount
					given = math.min(given, self.AmmoMax - ammo)
					ply:GiveAmmo(given, self.AmmoType)
					self:Remove()
					self.taken = true
				end
			end
		end
	end
end

if SERVER then
   function ENT:Think()
      if not self.first_think then
         self:PhysWake()
         self.first_think = true
         self.Think = nil
      end
   end
end