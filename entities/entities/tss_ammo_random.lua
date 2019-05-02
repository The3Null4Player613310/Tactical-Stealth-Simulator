
ENT.Type = "point"
ENT.Base = "base_point"

function ENT:Initialize()
	local ammo = {
	"tss_ammo_pistol",
	"tss_ammo_smg",
	"tss_ammo_shotgun",
	"tss_ammo_rifle",
	"tss_ammo_sniperrifle"}
	local ent = ents.Create(table.Random(ammo))
	if IsValid(ent) then
		ent:SetPos(self:GetPos())
		ent:SetAngles(self:GetAngles())
		ent:Spawn()
		ent:PhysWake()
	end
	self:Remove()
end