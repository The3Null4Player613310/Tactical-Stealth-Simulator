AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
local schdChase = ai_schedule.New( "AIFighter Chase" ) //creates the schedule used for this npc
 
 
	// Run away randomly (first objective in task)
	schdChase:EngTask( "TASK_GET_PATH_TO_RANDOM_NODE", 	128 )
	schdChase:EngTask( "TASK_RUN_PATH", 				0 )
	schdChase:EngTask( "TASK_WAIT_FOR_MOVEMENT", 	0 )
	schdChase:AddTask( "PlaySequence", 				{ Name = "cheer1", Speed = 1 } )
 
	// Find an enemy and run to it (second objectives in task)
	schdChase:AddTask( "FindEnemy", 		{ Class = "player", Radius = 2000 } )
	schdChase:EngTask( "TASK_GET_PATH_TO_RANGE_ENEMY_LKP_LOS", 	0 )
	schdChase:EngTask( "TASK_RUN_PATH", 				0 )
	schdChase:EngTask( "TASK_WAIT_FOR_MOVEMENT", 	0 )
 
	// Shoot it (third objective in task)
	schdChase:EngTask( "TASK_STOP_MOVING", 			0 )
	schdChase:EngTask( "TASK_FACE_ENEMY", 			0 )
	schdChase:EngTask( "TASK_ANNOUNCE_ATTACK", 		0 )
	schdChase:EngTask( "TASK_RANGE_ATTACK1", 		0 )
	schdChase:EngTask( "TASK_RELOAD", 				0 )
	//schedule is looped till you give it a different schedule
 
 
function ENT:Initialize()
 
	self:SetModel( "models/Humans/Group01/Female_01.mdl" )
 
	self:SetHullType( HULL_HUMAN );
	self:SetHullSizeNormal();
 
	self:SetSolid( SOLID_BBOX ) 
	self:SetMoveType( MOVETYPE_STEP )
 
	self:CapabilitiesAdd( CAP_MOVE_GROUND + CAP_OPEN_DOORS + CAP_ANIMATEDFACE + CAP_TURN_HEAD + CAP_USE_SHOT_REGULATOR + CAP_AIM_GUN )
 
	self:SetMaxYawSpeed( 5000 )
 
	//don't touch stuff above here
	self:SetHealth(100)
	self:Give( "weapon_pistol" ) //Can be given sweps.
 
end
 
 function ENT:OnTakeDamage(dmg)
  self:SetHealth(self:Health() - dmg:GetDamage())
  if self:Health() <= 0 then //run on death
  self:SetSchedule( SCHED_FALL_TO_GROUND ) //because it's given a new schedule, the old one will end.
  end
 end 
 
 
/*---------------------------------------------------------
   Name: SelectSchedule
---------------------------------------------------------*/
function ENT:SelectSchedule()
 
	self:StartSchedule( schdChase ) //run the schedule we created earlier
 
end