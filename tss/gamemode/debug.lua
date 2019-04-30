--misc debug
local PlayerTimes = PlayerTimes or {}
local EntList = EntList or {}
local delay = 60 --seconds

function scan()
	for k,v in pairs ( ents.GetAll() ) do
		print("Ent no:"..k.." "..v:GetClass())
		EntList[k] = v:GetClass()
	end
end
concommand.Add("ent_list",scan)

/*
function LogPlayerCon( name, ip )
	local id
	if ip == "none" then
		id = (name)
	else
		id = (ip)
	end
	PlayerTimes[id] = RealTime()
end
hook.Add("PlayerConnect","logplayercon",LogPlayerCon)
*/

/*
function LogPlayerDis(ply)
	local ip = ply:IPAddress()
	local name = ply:Name()
	local id
	if ip == "Error!" then
		id = (name)
	else
		id = (ip)
	end
	if ((PlayerTimes[id]+delay) > RealTime()) then
		scan()
		if not file.Exists( "connecterrorlog.txt", "DATA" ) then
			file.Write( "connecterrorlog.txt", "" )
		end
		 file.Append( "connecterrorlog.txt", id .. "\n" )
		 print(id)
		 for EntID = 1,#EntList do
			file.Append( "connecterrorlog.txt","Ent No:" .. EntID .." " .. EntList[EntID] .. "\n" )
			print("Ent No:" .. EntID .." " .. EntList[EntID])
		 end
		 file.Append( "connecterrorlog.txt", " \n" )
		
		PlayerTimes[id] = nil
	else
		PlayerTimes[id] = nil
	end
end
hook.Add("PlayerDisconnected","logplayerdis",LogPlayerDis)
/*