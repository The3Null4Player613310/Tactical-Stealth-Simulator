--tss loot spawner

AddCSLuaFile()

ENT.Type				= "point"
ENT.Base				= "base_point"
ENT.SpawnMin			= 30
ENT.SpawnMax			= 300
ENT.NextThinkTimeDelay	= 15
ENT.NextThinkTime		= 0

function ENT:Initialize()
	self:SetNWInt( "time", -1)
end

function ENT:Think()
	local ent = self:GetNWEntity( "loot", NULL )
	if !(IsValid(ent)) then
		if (self:GetNWInt( "time", 0 ) == 0) then
			self:SetNWInt( "time", CurTime()+math.random( self.SpawnMin, self.SpawnMax ) )
		else
			if (self:GetNWInt( "time", CurTime() ) < CurTime()) then
				
				local loot = {
					"tss_ammo_pistol",
					"tss_ammo_smg",
					"tss_ammo_shotgun",
					"tss_ammo_rifle",
					"tss_ammo_sniperrifle",
					"tss_ammo_hammer",
					"tss_weapon_pistol_deagle",
					"tss_weapon_pistol_fiveseven",
					"tss_weapon_pistol_glock18",
					"tss_weapon_pistol_p228",
					"tss_weapon_smg_mac10",
					"tss_weapon_smg_mp5",
					"tss_weapon_smg_p90",
					"tss_weapon_smg_tmp",
					"tss_weapon_smg_ump45",
					"tss_weapon_shotgun_m3super90",
					"tss_weapon_shotgun_xm1014",
					"tss_weapon_rifle_ak47",
					"tss_weapon_rifle_aug",
					"tss_weapon_rifle_famas",
					"tss_weapon_rifle_galil",
					"tss_weapon_rifle_sg552",
					"tss_weapon_sniperrifle_awm",
					"tss_weapon_sniperrifle_g3sg1",
					"tss_weapon_sniperrifle_scout",
					"tss_weapon_sniperrifle_sg550",
					"tss_weapon_grenade_f",
					"tss_weapon_grenade_h",
					"tss_weapon_grenade_s",
					"tss_weapon_hammer"}
				self.Loot = table.Random(loot)
				
				ent = ents.Create(self.Loot)
				ent:SetPos(self:GetPos())
				ent:SetAngles(self:GetAngles())
				ent:Spawn()
				ent:Activate()
				ent:PhysWake()
				self:SetNWEntity( "loot", ent )
				self:SetNWInt( "time", 0 )
			end
		end
	end
end