local WeatherUpdateTime = 0
local WindUpdateTime = 0
local EffectUpdateTime = 0
local WeatherSound = {}
local WeatherSoundVolume = {0,0,0}
local WeatherData = {
	{
		Effect = "tss_effect_rain",
		EffMagnitude = 30,
		SndPath = "ambient/water/water_flow_loop1.wav",
		SndInVolume = 0.05,
		SndOutVolume = 0.20
	},
	--{ -- this might be breaking the models
	--	Effect = "tss_effect_snow",
	--	EffMagnitude = 30,
	--	SndPath = "ambient/atmosphere/town_ambience.wav",
	--	SndInVolume = 0.30,
	--	SndOutVolume = 0.8	
	--},
}

	--"ambient/atmosphere/thunder.wav" add 1-4 on end of thunder

function WeatherThink()
	if SERVER then
		--update code
		if CurTime()>WeatherUpdateTime then
			--weather update
			WeatherUpdateTime=CurTime()+900 --300
			SetGlobalInt( "GlobalWeather", math.random(0,#WeatherData) ) --#WeatherData
		elseif CurTime()>WindUpdateTime then
			--wind update
			WindUpdateTime=CurTime()+300
			local maxwindspeed = 50
			local maxwindchange = 10
			local GlobalWind = GetGlobalVector( "GlobalWind", Vector(0,0,0))
			GlobalWind = Vector(math.Clamp(GlobalWind.x+math.random(-maxwindchange,maxwindchange),-maxwindspeed,maxwindspeed),math.Clamp(GlobalWind.y+math.random(-maxwindchange,maxwindchange),-maxwindspeed,maxwindspeed),0)
			SetGlobalVector( "GlobalWind", GlobalWind )
		end
		--weather code
		if CurTime()>EffectUpdateTime then
			EffectUpdateTime=CurTime()+1
			local weather = GetGlobalInt( "GlobalWeather", 0 )
			if (weather == 0) then
				--clear
			else
				local eff=EffectData()
				eff:SetMagnitude(WeatherData[weather].EffMagnitude)
				util.Effect(WeatherData[weather].Effect,eff)
			end
		end
	else
		if ( !IsValid( LocalPlayer() ) ) then return end
		local weather = GetGlobalInt( "GlobalWeather", 0 )
		local viewpoint = LocalPlayer():EyePos()
		
		for id=1,#WeatherData do
			if WeatherSound[id] == nil then
				WeatherSound[id] = CreateSound( LocalPlayer(), WeatherData[id].SndPath )
			end
			if (WeatherSound[id]:IsPlaying() == false) then
				WeatherSound[id]:PlayEx( 0, 100 )
			end
			if (id == weather) then
				if  util.IsSkyboxVisibleFromPoint( viewpoint ) and (LocalPlayer():Alive()) then --WIP
					local tracedata = {}
						tracedata.start = viewpoint
						tracedata.endpos = viewpoint + Vector(0,0,16384)
						tracedata.mask = MASK_BLOCKLOS
					local tr = util.TraceLine(tracedata)
					if (tr.HitSky) and (WeatherSoundVolume[weather] != WeatherData[weather].SndOutVolume)then
						WeatherSound[weather]:ChangeVolume( WeatherData[weather].SndOutVolume, 1 )
						WeatherSoundVolume[weather] = WeatherData[weather].SndOutVolume
					elseif (WeatherSoundVolume[weather] != WeatherData[weather].SndInVolume) then
						WeatherSound[weather]:ChangeVolume( WeatherData[weather].SndInVolume, 1 )
						WeatherSoundVolume[weather] = WeatherData[weather].SndInVolume
					end
				elseif (WeatherSoundVolume[weather] != 0) then
					WeatherSound[weather]:ChangeVolume( 0, 1 )
					WeatherSoundVolume[weather] = 0
				end
			elseif (WeatherSoundVolume[weather] != 0) then
				WeatherSound[id]:ChangeVolume( 0, 1 )
				WeatherSoundVolume[id] = 0
			end
		end
	end
end
hook.Add("Think","Weather",WeatherThink)