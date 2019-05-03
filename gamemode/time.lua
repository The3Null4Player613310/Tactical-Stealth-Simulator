
if (GetConVar("tss_experimental"):GetBool()) then --WIP

local EnvSun = nil
local EnvFogController = nil
local WorldSpawn = nil
local EnvSkypaint = nil
local LightEnvironment = nil
local oldstyle = nil

if SERVER then
	util.AddNetworkString( "update_lightmaps" )
end
	
function TimeThink()

	if SERVER then
		
		--time
		local tblTime = os.date( "!*t" , os.time() )
		tblTime.ttl = (tblTime.hour * 3600) + (tblTime.min * 60) + tblTime.sec -- (7*3600)
		
		--lighting
		local angle = (((tblTime.ttl/86400)*360)-90) --86400
		local style = string.char(math.Round(((math.sin((angle*(math.pi/180)))+1)*(25/2))+97))
		if !(style == oldstyle) then
			print(style)
			print(angle)
			for i=0, 63 do
				engine.LightStyle( i, style)
				print(i)
			end
			timer.Simple( 0.1, function()
				net.Start( "update_lightmaps" )
				net.Broadcast()
			end )
			oldstyle = style
		end
	
		if ( IsValid( EnvSun ) ) then
			local angle = Angle(((tblTime.ttl/86400)*360)+90,0,0) --86400
			angle:Normalize()
			EnvSun:SetKeyValue( "sun_dir", tostring( angle:Forward() ) ) 
		else
			EnvSun = ents.FindByClass( "env_sun" )[1]
			if !( IsValid( EnvSun ) ) then
				EnvSun = ents.Create( "env_sun" )
				EnvSun:SetKeyValue( "HDRColorScale", "1" )
				EnvSun:SetKeyValue( "material", "sprites/light_glow02_add_noz.vmt" )
				EnvSun:SetKeyValue( "overlaymaterial", "sprites/light_glow02_add_noz.vmt" )
				EnvSun:SetKeyValue( "pitch", "0" )
				EnvSun:Spawn()
				EnvSun:Activate()
			end
			--PrintTable(EnvSun:GetKeyValues())
			--print("end key val")
			--PrintTable(EnvSun:GetTable())
			--print("end table")
		end
		
		if ( IsValid( EnvFogController ) ) then
			--local angle = Angle(((tblTime.ttl/86400)*360)+90,0,0)
			--angle:Normalize()
			--EnvFogController:SetKeyValue( "sun_dir", tostring( angle:Forward() ) ) 
		else
			EnvFogController = ents.FindByClass( "env_fog_controller" )[1]
			if !( IsValid( EnvFogController ) ) then
				EnvFogController = ents.Create( "env_fog_controller" )
				EnvFogController:Spawn()
				EnvFogController:Activate()
			end
			EnvFogController:SetKeyValue( "farz", "32768" )
			EnvFogController:Fire( "SetColor", "0 0 0" )
			--PrintTable(EnvFogController:GetKeyValues())
			--print("end key val")
			--PrintTable(EnvFogController:GetTable())
			--print("end table")
		end
		
		--worldspawn
		--if ( IsValid( WorldSpawn ) ) then
	
		--else
		--	WorldSpawn = ents.FindByClass( "worldspawn" )[1]
		--	if ( IsValid( WorldSpawn ) ) then
		--		--WorldSpawn:SetKeyValue( "farz", "32768" )
		--		--WorldSpawn:Fire( "SetColor", "0 0 0" )
		--	end
		--	PrintTable(WorldSpawn:GetKeyValues())
		--	print("end key val")
		--	PrintTable(WorldSpawn:GetTable())
		--	print("end table")
		--end
		
		if ( IsValid( EnvSkypaint ) ) then
		else
			EnvSkypaint = ents.FindByClass( "env_skypaint" )[1]
			if !( IsValid( EnvSkypaint ) ) then
				EnvSkypaint = ents.Create( "env_skypaint" )
				EnvSkypaint:Spawn()
				EnvSkypaint:Activate()
			end
			EnvSkypaint:SetStarTexture( "skybox/starfield" )
			--PrintTable(EnvSkypaint:GetKeyValues())
			--print("end key val")
			--PrintTable(EnvSkypaint:GetTable())
			--print("end table")
		end
			
		if ( IsValid( LightEnvironment ) ) then
			--local angle = (((tblTime.ttl/86400)*360)+90)
			--local style = string.char(math.Round(((math.sin((angle*(math.pi/180)))+1)*(25/2))+97))
			--if !(style == oldstyle) then
			--	print(style)
			--	print(angle)
			--	oldstyle = style
			--end
			--LightEnvironment:Fire( "FadeToPattern", tostring( style ) )
		else
			LightEnvironment = ents.FindByClass( "light_environment" )[1]
			if !( IsValid( LightEnvironment ) ) then
				LightEnvironment = ents.Create( "light_environment" )
				--WIP
			end
			--PrintTable(LightEnvironment:GetKeyValues())
			--print("end key val")
			--PrintTable(LightEnvironment:GetTable())
			--print("end table")
		end
		
	elseif CLIENT then
	else
		print("Weird?")
	end
end
hook.Add("Think","Time",TimeThink)

if CLIENT then
	net.Receive( "update_lightmaps", function( len )
		render.RedownloadAllLightmaps()
	end )
end

end