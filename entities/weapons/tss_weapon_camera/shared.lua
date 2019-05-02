AddCSLuaFile()

--set swep values
SWEP.ViewModel = Model("models/weapons/c_arms_animations.mdl")
SWEP.WorldModel = Model("models/MaxOfS2D/camera.mdl")
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.PrintName = "Camera"
SWEP.Slot = 5
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Spawnable = true
SWEP.ShootSound = Sound("NPC_CScanner.TakePhoto")

if (SERVER) then
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom	= false
end

--
-- Network/Data Tables
--
function SWEP:SetupDataTables()
	self:NetworkVar( "Float", 0, "Zoom" )
	self:NetworkVar( "Float", 1, "Roll" )
	if ( SERVER ) then
		self:SetZoom( 70 )
		self:SetRoll( 0 )
	end
end

--init
function SWEP:Initialize()
	self:SetHoldType("camera")
end

--reset role and fov
function SWEP:Reload()
	if ( !self.Owner:KeyDown(IN_ATTACK2)) then self:SetZoom( self.Owner:IsBot() && 75 || self.Owner:GetInfoNum( "fov_desired", 75 ) ) end
	self:SetRoll(0)
end

--take a picture
function SWEP:PrimaryAttack()
	self:DoShootEffect()
	if ( !game.SinglePlayer() && SERVER ) then return end
	if ( CLIENT && !IsFirstTimePredicted() ) then return end
	self.Owner:ConCommand("jpeg")
end

function SWEP:SecondaryAttack()
end

function SWEP:Tick()
	if (CLIENT && self.Owner != LocalPlayer()) then return end
	local cmd = self.Owner:GetCurrentCommand()
	if (!cmd:KeyDown(IN_ATTACK2)) then return end
	self:SetZoom(math.Clamp(self:GetZoom()+cmd:GetMouseY() * 0.1, 0.1, 175 ) ) --control zoom
	self:SetRoll(self:GetRoll()+cmd:GetMouseX()*0.025) --control rotation
end

--alter field of view
function SWEP:TranslateFOV(current_fov)
	return self:GetZoom()
end

function SWEP:Deploy()
	return true
end

function SWEP:Equip()
	if(self:GetZoom() == 70 && self.Owner:IsPlayer() && !self.Owner:IsBot()) then
		self:SetZoom(self.Owner:GetInfoNum("fov_desired",75))
	end
end

--control weather camera should be dropped on death
function SWEP:ShouldDropOnDie() 
	return true
end


function SWEP:DoShootEffect()
	self:EmitSound(self.ShootSound)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	if (SERVER && !game.SinglePlayer()) then
		local vPos = self.Owner:GetShootPos()
		local vForward = self.Owner:GetAimVector()
		local trace = {}
		trace.start = vPos
		trace.endpos = vPos+vForward*256
		trace.filter = self.Owner
		local tr = util.TraceLine(trace)
		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		util.Effect("camera_flash",effectdata,true)
	end
end