--send files to client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

--execute files
include("shared.lua")

function ENT:Initialize()
	local GuardModel = {
	"models/odessa.mdl"
	}
	self:SetModel(GuardModel[math.random(1)]) --math.random(3)
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid( SOLID_BBOX )
	--self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_STEP )
	
	--set capabilities
	self:CapabilitiesAdd( CAP_MOVE_GROUND )
	self:CapabilitiesAdd( CAP_MOVE_SWIM )
	self:CapabilitiesAdd( CAP_MOVE_CRAWL )
	self:CapabilitiesAdd( CAP_MOVE_SHOOT )
	self:CapabilitiesAdd( CAP_USE )
	self:CapabilitiesAdd( CAP_AUTO_DOORS )
	self:CapabilitiesAdd( CAP_OPEN_DOORS )
	self:CapabilitiesAdd( CAP_TURN_HEAD )
	self:CapabilitiesAdd( CAP_USE_WEAPONS )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:CapabilitiesAdd( CAP_SQUAD )
	self:CapabilitiesAdd( CAP_DUCK )
	self:CapabilitiesAdd( CAP_USE_SHOT_REGULATOR )
	self:CapabilitiesAdd( CAP_AIM_GUN )
	self:CapabilitiesAdd( CAP_NO_HIT_SQUADMATES )
	
	--set relationships
	self:AddRelationship("player D_HT 999")

	self:SetMaxYawSpeed( 45 )
	self:SetHealth(100)
	self:Give( "tss_weapon_pistol" )
	self:SetUseType( SIMPLE_USE )
	self:DrawShadow( true )
	--self:DropToFloor()
	local phys = self:GetPhysicsObject()
	if(IsValid(phys)) then phys:Wake() end
	self.Engine = NULL
end

function ENT:SpawnFunction(ply,tr,class)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create(class)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:SelectSchedule()
	if (self:GetNPCState() == NPC_STATE_NONE) then
	
		self:SetSchedule( SCHED_PATROL_WALK )
	
	elseif (self:GetNPCState() == NPC_STATE_IDLE) then
	
		local rnd = math.random(2)
		if (rnd == 1) then
			self:SetSchedule( SCHED_IDLE_WANDER )
		elseif (rnd == 2) then
			self:SetSchedule( SCHED_IDLE_STAND )
		end

	elseif (self:GetNPCState() == NPC_STATE_ALERT) then
		
		local rnd = math.random(2)
		if (rnd == 1) then
			self:SetSchedule( SCHED_PATROL_WALK )
		elseif (rnd == 2) then
			self:SetSchedule( SCHED_PATROL_RUN )
		end

	elseif (self:GetNPCState() == NPC_STATE_COMBAT) then

		local rnd = math.random(4)
		if (rnd == 1) then
			self:SetSchedule( SCHED_COMBAT_STAND )
		elseif (rnd == 2) then
			self:SetSchedule( SCHED_COMBAT_SWEEP )
		elseif (rnd == 3) then
			self:SetSchedule( SCHED_COMBAT_PATROL )
		elseif (rnd == 4) then
			self:SetSchedule( SCHED_COMBAT_WALK )
		end
		
	elseif (self:GetNPCState() == NPC_STATE_SCRIPT) then

		self:SetSchedule( SCHED_AISCRIPT )

	elseif (self:GetNPCState() == NPC_STATE_PLAYDEAD) then

		self:SetSchedule( SCHED_FALL_TO_GROUND )

	elseif (self:GetNPCState() == NPC_STATE_PRONE) then
	
		local rnd = math.random(2)
		if (rnd == 1) then
			self:SetSchedule( SCHED_COWER )
		elseif (rnd == 2) then
			self:SetSchedule( SCHED_RUN_RANDOM )
		end

	elseif (self:GetNPCState() == NPC_STATE_DEAD) then

		self:SetSchedule( SCHED_FALL_TO_GROUND ) //SCHED_DIE )

	elseif (self:GetNPCState() == NPC_STATE_INVALID) then

		self:SetNPCState( NPC_STATE_NONE )

	end
 
end

function ENT:Alive()
	if self:Health() > 0 then
		return true
	else
		return false
	end
end

function ENT:OnTakeDamage( dmg )

	self:TakePhysicsDamage( dmg )
	
	--exit if dead
	if !(self:Alive()) then return end
	
	--scream in pain
	self:EmitSound( VMale[ math.random( 374, 382 ) ] )

	--set health
	self:SetHealth(self:Health() - dmg:GetDamage())
	if self:Health() <= 0 then --run on death
		self:SetHealth(0)
	end
	
	--set npc state
	if self:Health() == 0 then
		self:SetNPCState( NPC_STATE_DEAD )
	elseif self:Health() <= 25 then
		self:SetNPCState( NPC_STATE_PRONE )
	elseif self:Health() >= 26 then
		self:SetNPCState( NPC_STATE_COMBAT )
	end
	
	--update schedule
	self:SelectSchedule( self:GetNPCState() )
	
	--PrintMessage( HUD_PRINTTALK, self:Health())
end 