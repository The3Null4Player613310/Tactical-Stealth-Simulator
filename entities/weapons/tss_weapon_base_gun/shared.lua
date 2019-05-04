
-- Variables that are used on both client and server

SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel				= "models/weapons/c_pistol.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"

SWEP.ViewModelFlip			= false
SWEP.ViewModelFlip1			= false
SWEP.ViewModelFlip2			= false
if IsMounted( "cstrike" ) then
	SWEP.CSMuzzleFlashes		= true
	SWEP.CSMuzzleX				= true
else
	SWEP.CSMuzzleFlashes		= false
	SWEP.CSMuzzleX				= false
end
SWEP.HoldType				= "pistol"

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "tss_ammo_pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "Pistol"			
SWEP.Slot					= 1
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false
SWEP.UseHands				= true

SWEP.DamagePerShot			= 25
SWEP.Accuracy				= 50
SWEP.FireRate				= 6
SWEP.BulletsPerShot			= 1

SWEP.AllowAim				= false
SWEP.AimTime				= 0.25
SWEP.AimBob					= 0
SWEP.AimSway				= 0
SWEP.AimFOV					= 65
SWEP.AimPosX				= 5.5
SWEP.AimPosY				= 3.2
SWEP.AimPosZ				= 0
SWEP.AimAngX				= 0 --good
SWEP.AimAngY				= 0 --bad try to fix this if you can. think about a sphere and the distance between two points as they travel from the bottom to the top of sphere on the surface. the points have same longitude.
SWEP.AimAngZ				= 0 --good

SWEP.ShootSingleSound		= Sound( "Weapon_Pistol.Single" )
SWEP.ShootBurstSound		= Sound( "Weapon_Pistol.Burst" )
SWEP.ReloadSound			= Sound( "Weapon_Pistol.Reload" )
SWEP.EmptySound				= Sound( "Weapon_Pistol.Empty" )

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:Reload()
	if (self:DefaultReload( ACT_VM_RELOAD )) then
		if self:GetNWBool( "Aim", false ) then
			self:Aim()
		end
		self.Weapon:SetNextPrimaryFire( CurTime() + (1) )
		self:EmitSound( self.ReloadSound )
	end
end

function SWEP:Think()	
end

function SWEP:PrimaryAttack()
	if self.Owner:Alive() then
		self:FireRound()
	end
end

function SWEP:SecondaryAttack()
	if self.AllowAim then
		self:Aim()
	end
end

function SWEP:Deploy() --WIP
	self:SetNWBool( "Aim", false )
	return true
end

function SWEP:FireRound()
	if (! self.Owner:IsPlayer()) then
		if SERVER then
			--PrintMessage( HUD_PRINTTALK, "Bang" )
		end
	end
	local vm
	if (self.Owner:IsPlayer()) then
		vm = self.Owner:GetViewModel()
	end
	if (self:CanPrimaryAttack() && (CurTime() >= self.Weapon:GetNextPrimaryFire())) then
		self.Weapon:SetNextPrimaryFire( CurTime() + (1/self.FireRate) )
		self:EmitSound( self.ShootSingleSound )
		self:ShootEffects( self )
		if (self.Owner:IsPlayer()) then
			self:TakePrimaryAmmo( 1 ) --WIP
		end
		if ((CurTime()-self:GetVar("LastFireTime", 0 ))<(2/self.FireRate)) &&(self:GetVar("ShotCounter", 1 ) < (self.Primary.ClipSize/2) ) then --WIP -max was a static (10) changed to (self.Primary.ClipSize/2)
				self:SetVar("ShotCounter", self:GetVar("ShotCounter", 1 ) + 1 ) 
			else
				self:SetVar("ShotCounter", 1 )
		end
		local accuracy = self.Accuracy
		local dynaccuracy = math.sqrt((CurTime()-self:GetVar("LastFireTime", 0 ))/(self:GetVar("ShotCounter", 1 )*2/self.FireRate))*accuracy
		if dynaccuracy < accuracy then
				accuracy = dynaccuracy //equals 0 sometimes and thats a nono
				print(accuracy)
		end
		self:ShootBullet( (self.DamagePerShot/self.BulletsPerShot), self.BulletsPerShot, (1/accuracy))
		self:SetVar("LastFireTime", CurTime() )
		--if SERVER then
		--	PrintMessage( HUD_PRINTTALK, self:GetVar("ShotCounter", 1 ) .." : ".. accuracy )
		--end
	else
		if (self.Owner:IsPlayer()) then
			if (self:Ammo1() == 0) then
				self:EmitSound( self.EmptySound )
					vm:SendViewModelMatchingSequence(vm:LookupSequence("fireempty"))
			else
				self:Reload()
			end
		end
	end
end

function SWEP:Aim()
	if ( CurTime() > self:GetNWFloat( "AimTransEnd", 0 ) ) then --WIP
		if (self:GetNWBool( "Aim", false )) then
			self:SetNWBool( "Aim", false )
			self:SetNWFloat( "AimTransBegin", CurTime() )
			self:SetNWFloat( "AimTransEnd", CurTime()+self.AimTime )
			self.Weapon:SetNextPrimaryFire( self:GetNWFloat( "AimTransEnd", 0 ) )
			self.Owner:SetFOV( 0, self.AimTime)
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
			--self.Owner:SetWalkSpeed( self.Owner:GetWalkSpeed() * (2/1))
			--print( self.Owner:GetWalkSpeed())
		else
			self:SetNWBool( "Aim", true )
			self:SetNWFloat( "AimTransBegin", CurTime() )
			self:SetNWFloat( "AimTransEnd", CurTime()+self.AimTime )
			self.Weapon:SetNextPrimaryFire( self:GetNWFloat( "AimTransEnd", 0 ) )
			self.Owner:SetFOV( self.AimFOV, self.AimTime)
			self.SwayScale 	= self.AimSway
			self.BobScale 	= self.AimBob
			--self.Owner:SetWalkSpeed( self.Owner:GetWalkSpeed() * (1/2))
			--print( self.Owner:GetWalkSpeed())
		end
	end
	--PrintTable( self:GetSequenceList() )
end

function SWEP:GetViewModelPosition( pos, ang ) --WIP
	if CurTime() > self:GetNWFloat( "AimTransEnd", 0 ) then
		if (self:GetNWBool( "Aim", false )) then
			--pos code
			pos.x = pos.x+((math.cos(math.rad(ang.y+90))*self.AimPosX)+(math.cos(math.rad(ang.y))*(math.cos(math.rad(90-ang.p))*self.AimPosY))+(math.cos(math.rad(ang.y))*(math.cos(math.rad(-ang.p))*self.AimPosZ)))
			pos.y = pos.y+((math.sin(math.rad(ang.y+90))*self.AimPosX)+(math.sin(math.rad(ang.y))*(math.cos(math.rad(90-ang.p))*self.AimPosY))+(math.sin(math.rad(ang.y))*(math.cos(math.rad(-ang.p))*self.AimPosZ)))
			pos.z = pos.z+((math.sin(math.rad(90-ang.p))*self.AimPosY)+(math.sin(math.rad(-ang.p))*self.AimPosZ))
			--ang code
			ang.p = ang.p + self.AimAngX
			ang.y = ang.y + self.AimAngY
			ang.r = ang.r + self.AimAngZ
		else
			--pos code
			pos.x = pos.x
			pos.y = pos.y
			pos.z = pos.z
			--ang code
			ang.p = ang.p
			ang.y = ang.y
			ang.r = ang.r
		end
	else
		if (self:GetNWBool( "Aim", false )) then
			--pos code
			pos.x = pos.x+(((math.cos(math.rad(ang.y+90))*self.AimPosX)+(math.cos(math.rad(ang.y))*(math.cos(math.rad(90-ang.p))*self.AimPosY))+(math.cos(math.rad(ang.y))*(math.cos(math.rad(-ang.p))*self.AimPosZ)))*((CurTime()-self:GetNWFloat( "AimTransBegin", 0 ))/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			pos.y = pos.y+(((math.sin(math.rad(ang.y+90))*self.AimPosX)+(math.sin(math.rad(ang.y))*(math.cos(math.rad(90-ang.p))*self.AimPosY))+(math.sin(math.rad(ang.y))*(math.cos(math.rad(-ang.p))*self.AimPosZ)))*((CurTime()-self:GetNWFloat( "AimTransBegin", 0 ))/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			pos.z = pos.z+(((math.sin(math.rad(90-ang.p))*self.AimPosY)+(math.sin(math.rad(-ang.p))*self.AimPosZ))*((CurTime()-self:GetNWFloat( "AimTransBegin", 0 ))/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			--ang code
			ang.p = ang.p+((self.AimAngX)*((CurTime()-self:GetNWFloat( "AimTransBegin", 0 ))/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			ang.y = ang.y+((self.AimAngY)*((CurTime()-self:GetNWFloat( "AimTransBegin", 0 ))/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			ang.r = ang.r+((self.AimAngZ)*((CurTime()-self:GetNWFloat( "AimTransBegin", 0 ))/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
		else
			--pos code
			pos.x = pos.x+(((math.cos(math.rad(ang.y+90))*self.AimPosX)+(math.cos(math.rad(ang.y))*(math.cos(math.rad(90-ang.p))*self.AimPosY))+(math.cos(math.rad(ang.y))*(math.cos(math.rad(-ang.p))*self.AimPosZ)))*((self:GetNWFloat( "AimTransEnd", 0 )-CurTime())/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			pos.y = pos.y+(((math.sin(math.rad(ang.y+90))*self.AimPosX)+(math.sin(math.rad(ang.y))*(math.cos(math.rad(90-ang.p))*self.AimPosY))+(math.sin(math.rad(ang.y))*(math.cos(math.rad(-ang.p))*self.AimPosZ)))*((self:GetNWFloat( "AimTransEnd", 0 )-CurTime())/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			pos.z = pos.z+(((math.sin(math.rad(90-ang.p))*self.AimPosY)+(math.sin(math.rad(-ang.p))*self.AimPosZ))*((self:GetNWFloat( "AimTransEnd", 0 )-CurTime())/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			--ang code
			ang.p = ang.p+((self.AimAngX)*((self:GetNWFloat( "AimTransEnd", 0 )-CurTime())/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			ang.y = ang.y+((self.AimAngY)*((self:GetNWFloat( "AimTransEnd", 0 )-CurTime())/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
			ang.r = ang.r+((self.AimAngZ)*((self:GetNWFloat( "AimTransEnd", 0 )-CurTime())/(self:GetNWFloat( "AimTransEnd", 0 )-self:GetNWFloat( "AimTransBegin", 0 ))))
		end
	end
	return pos, ang
end

function SWEP:ShouldDropOnDie()
	return true
end