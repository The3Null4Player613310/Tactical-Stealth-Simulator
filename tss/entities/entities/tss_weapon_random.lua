
ENT.Type = "point"
ENT.Base = "base_point"

function ENT:Initialize()
	local weapons = {
	"tss_weapon_pistol",
	"tss_weapon_smg",
	"tss_weapon_shotgun",
	"tss_weapon_rifle",
	"tss_weapon_sniperrifle",
	"tss_weapon_grenade_f",
	"tss_weapon_grenade_h",
	"tss_weapon_grenade_s"}
	local ent = ents.Create(table.Random(weapons))
	if IsValid(ent) then
		ent:SetPos(self:GetPos())
		ent:SetAngles(self:GetAngles())
		ent:Spawn()
		ent:PhysWake()
	end
	self:Remove()
end
