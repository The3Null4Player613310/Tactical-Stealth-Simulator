--tss weapon spawner base

AddCSLuaFile()

ENT.Type 				= "point"
ENT.Base 				= "base_point"
ENT.WeaponType 			= "tss_weapon_pistol"
ENT.Weapon 				= "tss_weapon_pistol"
ENT.SpawnMin 			= 30
ENT.SpawnMax 			= 300

function ENT:Initialize()
	self:SetNWInt( "time", -1)
end

function ENT:Think()
	local ent = self:GetNWEntity( "weapon", NULL )
	if !(IsValid(ent)) then
		if (self:GetNWInt( "time", 0 ) == 0) then
			self:SetNWInt( "time", CurTime()+math.random( self.SpawnMin, self.SpawnMax ) )
		else
			if (self:GetNWInt( "time", CurTime() ) < CurTime()) then
				
				if (self.WeaponType == "tss_weapon_pistol") then
					local weapons = {
						"tss_weapon_pistol_deagle",
						"tss_weapon_pistol_fiveseven",
						"tss_weapon_pistol_glock18",
						"tss_weapon_pistol_p228"}
						
					self.Weapon = table.Random(weapons)
				elseif (self.WeaponType == "tss_weapon_smg") then
					local weapons = {
						"tss_weapon_smg_mac10",
						"tss_weapon_smg_mp5",
						"tss_weapon_smg_p90",
						"tss_weapon_smg_tmp",
						"tss_weapon_smg_ump45"}
					self.Weapon = table.Random(weapons)
				elseif (self.WeaponType == "tss_weapon_shotgun") then
					local weapons = {
						"tss_weapon_shotgun_m3super90",
						"tss_weapon_shotgun_xm1014"}
					self.Weapon = table.Random(weapons)
				elseif (self.WeaponType == "tss_weapon_rifle") then
					local weapons = {
						"tss_weapon_rifle_ak47",
						"tss_weapon_rifle_aug",
						"tss_weapon_rifle_famas",
						"tss_weapon_rifle_galil",
						"tss_weapon_rifle_sg552"}
					self.Weapon = table.Random(weapons)
				elseif (self.WeaponType == "tss_weapon_sniperrifle") then
					local weapons = {
						"tss_weapon_sniperrifle_awm",
						"tss_weapon_sniperrifle_g3sg1",
						"tss_weapon_sniperrifle_scout",
						"tss_weapon_sniperrifle_sg550"}
					self.Weapon = table.Random(weapons)
				elseif (self.WeaponType == "random") then
					local weapons = {
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
						"tss_weapon_grenade_s"}
					self.Weapon = table.Random(weapons)
				else
					self.Weapon = self.WeaponType
				end
				ent = ents.Create(self.Weapon)
				ent:SetPos(self:GetPos())
				ent:SetAngles(self:GetAngles())
				ent:Spawn()
				ent:Activate()
				ent:PhysWake()
				self:SetNWEntity( "weapon", ent )
				self:SetNWInt( "time", 0 )
			end
		end
	end
end