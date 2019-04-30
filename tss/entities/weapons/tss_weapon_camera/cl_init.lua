--execute files
include("shared.lua")


--Add Client Code HERE

SWEP.WepSelectIcon = surface.GetTextureID("vgui/gmod_camera")

--draw hud
function SWEP:DrawHUD()
end

--draw weapon info
function SWEP:PrintWeaponInfo( x, y, alpha )
end

--control what parts of hud should be drawn
function SWEP:HUDShouldDraw(name)
	if (name == "CHudWeaponSelection") then
		return true
	end
	if (name == "CHudChat") then
		return true 
	end
	return false
end

--stop camera from moving while right mouse button is held in
function SWEP:FreezeMovement()
	if (self.Owner:KeyDown(IN_ATTACK2) || self.Owner:KeyReleased(IN_ATTACK2)) then
		return true
	end
	return false
end

function SWEP:CalcView(ply,origin,angles,fov)
	if (self:GetRoll() != 0) then
		angles.Roll = self:GetRoll()
	end
	return origin,angles,fov
end

function SWEP:AdjustMouseSensitivity()
	if (self.Owner:KeyDown(IN_ATTACK2)) then
		return 1 
	end
	return self:GetZoom()/80
end
