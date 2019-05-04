
-- Variables that are used on both client and server

SWEP.Instructions			= ""

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.ViewModel 				= "models/weapons/c_hammer.mdl"
SWEP.WorldModel 			= "models/weapons/w_hammer.mdl"

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

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "tss_ammo_hammer"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName				= "Hammer"			
SWEP.Slot					= 0
SWEP.SlotPos				= 2
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false
SWEP.UseHands				= true

SWEP.FireRate				= 6

SWEP.ReloadSound			= Sound( "Weapon_Pistol.Reload" )
SWEP.EmptySound				= Sound( "Weapon_Pistol.Empty" )
SWEP.DrillSound = {
	Sound( "npc/dog/dog_servo6.wav" ),
	Sound( "npc/dog/dog_servo7.wav" ),
	Sound( "npc/dog/dog_servo10.wav" ),
	Sound( "npc/dog/dog_servo12.wav" ),
	Sound( "ambient/machines/pneumatic_drill_1.wav" ),
	Sound( "ambient/machines/pneumatic_drill_2.wav" ),
	Sound( "ambient/machines/pneumatic_drill_3.wav" ),
	Sound( "ambient/machines/pneumatic_drill_4.wav" )}
SWEP.HammerSound = {
	Sound( "physics/wood/wood_plank_impact_hard2.wav" ),
	Sound( "physics/wood/wood_plank_impact_hard3.wav" ),
	Sound( "physics/wood/wood_plank_impact_hard4.wav" )}
SWEP.SwingSound = {
	Sound("WeaponFrag.Throw")}

SWEP.Barricade				= Model( "models/props_debris/wood_board04a.mdl" )
SWEP.Angle					= 0

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:Reload()
	--if (self:DefaultReload( ACT_VM_RELOAD )) then
	--	self.Weapon:SetNextPrimaryFire( CurTime() + (1) )
	--	--self:EmitSound( self.ReloadSound )
	--end
end

function SWEP:Think() --WIP
	if CLIENT then
		if self.GhostEntity then
			self:UpdateGhost()
		end
	else
		--print( self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) )
		--print((self.Weapon:Clip1() < self.Weapon:GetMaxClip1()))
	end
	if ( (self.Weapon:Clip1() < self.Weapon:GetMaxClip1()) && (self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) > 0)) then
			self.Owner:RemoveAmmo( 1, self.Weapon:GetPrimaryAmmoType() )
			self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
	end
end

function SWEP:PrimaryAttack()
	if self.Owner:Alive() then
		self:BuildBarricade()
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:Alive() and SERVER then
		self:RotateBarricade()
	end
end

function SWEP:Deploy()
	if SERVER then
		self:CallOnClient( "MakeGhost", "")
	end
	return true
end

function SWEP:Holster( wep )
	if SERVER then
		self:CallOnClient( "ReleaseGhost", "")
	end
	return true
end

function SWEP:BuildBarricade()
	local vm = self.Owner:GetViewModel()
	if ( self.Weapon:CanPrimaryAttack() ) then
		local tr = self.Owner:GetEyeTrace()
			tr.length = (self.Owner:EyePos() - tr.HitPos):Length()
		if tr.HitWorld and tr.length < 150 then
			self.Weapon:TakePrimaryAmmo( 1 )
			self.Weapon:SetNextPrimaryFire( CurTime() + (1/self.FireRate) )
			self.Owner:EmitSound( table.Random( self.SwingSound ), 100, math.random(90,110) )
			self.Owner:EmitSound( table.Random( self.HammerSound ), 100, math.random(90,110) )
			self:ShootEffects( self )
			if SERVER then
				local prop = ents.Create( "prop_physics" )
					prop:SetModel( self.Barricade )
					prop:Spawn()
					prop:SetHealth( 100 )
					prop:SetCustomCollisionCheck()
					prop:SetAngles( (tr.HitNormal):Angle() + Angle( 0, 0, math.NormalizeAngle(90+self.Angle)) )
					prop:SetPos( tr.HitPos + ( prop:GetUp() * -32 ) )
				local phys = prop:GetPhysicsObject()
				if IsValid( phys ) then
					phys:EnableMotion( false )
				end
			end
		end
	else
		if (self:Ammo1() == 0) then
			if SERVER then
				--self:CallOnClient( "ReleaseGhost", "")
			else
				self:ReleaseGhost()
			end
		else
			self:Reload()
		end
	end
end

function SWEP:RotateBarricade()
	self.Angle = self.Angle+45
	if self.Angle == 360 then
		self.Angle = 0
	end
	self:SetNWInt("Angle",self.Angle)
end

function SWEP:ShouldDropOnDie()
	return true --WIP this is called on death
end

function SWEP:MakeGhost()
	--print("Make")
	if self.GhostEntity then 
		return 
	end
	local tr = self.Owner:GetEyeTrace()
		tr.length = (self.Owner:EyePos() - tr.HitPos):Length()
	self.GhostEntity = ents.CreateClientProp( self.Barricade )
	self.GhostEntity:SetAngles(  (tr.HitNormal):Angle() + Angle( 0, 0, math.NormalizeAngle(90+self:GetNWInt("Angle",self.Angle))) )
	self.GhostEntity:SetPos( tr.HitPos )
	self.GhostEntity:Spawn()
	self.GhostEntity:SetSolid( SOLID_VPHYSICS )
	self.GhostEntity:SetMoveType( MOVETYPE_NONE )
	self.GhostEntity:SetNotSolid( true )
	self.GhostEntity:SetColor( Color( 255, 255, 255, 0 ) )
	self.GhostEntity:SetRenderMode( RENDERMODE_TRANSALPHA )
end

function SWEP:UpdateGhost()
	--print("Update")
	if not IsValid( self.GhostEntity ) 
		then return 
	end
	local tr = self.Owner:GetEyeTrace()
		tr.length = (self.Owner:EyePos() - tr.HitPos):Length()
	if (tr.length < 150) and tr.HitWorld then
		self.GhostEntity:SetColor( Color( 255, 255, 255, 225-tr.length ) ) --200 is ideal
		self.GhostEntity:SetRenderMode( RENDERMODE_TRANSALPHA )
	else
		self.GhostEntity:SetColor( Color( 255, 255, 255, 0 ) )
		self.GhostEntity:SetRenderMode( RENDERMODE_TRANSALPHA )
	end
	self.GhostEntity:SetAngles( (tr.HitNormal):Angle() + Angle( 0, 0, math.NormalizeAngle(90+self:GetNWInt("Angle",self.Angle))) )
	self.GhostEntity:SetPos( tr.HitPos + ( self.GhostEntity:GetUp() * -32 ) )
end

function SWEP:ReleaseGhost()
	--print("Release")
	if IsValid( self.GhostEntity ) then
		self.GhostEntity:Remove()
		self.GhostEntity = nil
	end
end