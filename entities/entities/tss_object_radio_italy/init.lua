--send files to client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

--execute files
include("shared.lua")

--Radio Station Song Library
local MRadioStation1 = { --music to be played through radio
	{
		Path = "tss_audio_radio/stations/vault/vault_01.wav",
		Length = 155 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/vault/vault_02.wav",
		Length = 176 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/vault/vault_03.wav",
		Length = 162 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/vault/vault_04.wav",
		Length = 133 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/vault/vault_05.wav",
		Length = 158 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/vault/vault_06.wav",
		Length = 138 --length of song in seconds
	}
}

local MRadioStation2 = { --music to be played through radio
	{
		Path = "tss_audio_radio/stations/mbr/blues_for_you.wav",
		Length = 145 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mbr/jazz_blues_gt.wav",
		Length = 297 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mbr/jazz_club_blues_cas.wav",
		Length = 218 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mbr/joe_cool_cas.wav",
		Length = 145 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mbr/manhattan.wav",
		Length = 81 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mbr/sleepy_town_blues_cas.wav",
		Length = 158 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mbr/slow_bounce.wav",
		Length = 124 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mbr/slow_sax_kos.wav",
		Length = 159 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mbr/why_dont_you_do_right.wav",
		Length = 202 --length of song in seconds
	}
}

local MRadioStation3 = { --music to be played through radio
	{
		Path = "tss_audio_radio/stations/enclave/enclave_america.wav",
		Length = 67 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/enclave/enclave_battlehymn.wav",
		Length = 30 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/enclave/enclave_dixie.wav",
		Length = 47 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/enclave/enclave_montezuma.wav",
		Length = 42 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/enclave/enclave_presidential.wav",
		Length = 70 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/enclave/enclave_stars.wav",
		Length = 82 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/enclave/enclave_washington.wav",
		Length = 56 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/enclave/enclave_yankee.wav",
		Length = 73 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/enclave/march_washingtonpost.wav",
		Length = 146 --length of song in seconds
	}
}

local MRadioStation4 = { --music to be played through radio
	{
		Path = "tss_audio_radio/stations/mmr/big_iron.wav",
		Length = 238 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/eddyarnold_rca_itsasin.wav",
		Length = 146 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/goin_under.wav",
		Length = 176 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/happy_times.wav",
		Length = 117 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/heartaches_by_the_number.wav",
		Length = 153 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/i_m_movin_out.wav",
		Length = 174 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/i_m_so_blue.wav",
		Length = 216 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/in_the_shadow_of_the_valley.wav",
		Length = 186 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/its_a_sin_to_tell_a_lie.wav",
		Length = 140 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/johnny_guitar.wav",
		Length = 182 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/lazy_day_blues.wav",
		Length = 168 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/let_s_ride_into_the_sunset_together.wav",
		Length = 183 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/lone_star.wav",
		Length = 150 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/roundhouse_rock.wav",
		Length = 167 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/mmr/stars_of_the_midnight_range.wav",
		Length = 172 --length of song in seconds
	}
}

local MRadioStation5 = { --music to be played through radio
	{
		Path = "tss_audio_radio/stations/gnr/billieholiday_crazy.wav",
		Length = 183 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/billieholiday_easy.wav",
		Length = 182 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/bobcrosby_happy.wav",
		Length = 160 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/bobcrosby_way.wav",
		Length = 170 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/coleporter_anything.wav",
		Length = 187 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/dannykaye_civilization.wav",
		Length = 180 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/ellafitzgerald_into.wav",
		Length = 185 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/generic_boogie.wav",
		Length = 141 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/generic_fox.wav",
		Length = 194 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/generic_jazzy.wav",
		Length = 168 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/generic_jolly.wav",
		Length = 97 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/generic_pink.wav",
		Length = 108 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/generic_rhythm.wav",
		Length = 177 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/generic_sunning.wav",
		Length = 100 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/generic_swing.wav",
		Length = 177 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/inkspots_idont.wav",
		Length = 185 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/inkspots_maybe.wav",
		Length = 169 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/roybrown_butcher.wav",
		Length = 145 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/roybrown_mighty.wav",
		Length = 151 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/gnr/texbeneke_guy.wav",
		Length = 112 --length of song in seconds
	}
}

local MRadioStation6 = { --music to be played through radio
	{
		Path = "tss_audio_radio/stations/nvr/aint_that_a_kick_in_the_head.wav",
		Length = 145 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/american_swing.wav",
		Length = 94 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/big_iron.wav",
		Length = 238 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/blue_moon.wav",
		Length = 171 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/hallo_mister_x.wav",
		Length = 129 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/heartaches_by_the_number.wav",
		Length = 153 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/its_a_sin_to_tell_a_lie.wav",
		Length = 140 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/jingle_jangle_jingle.wav",
		Length = 199 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/johnny_guitar.wav",
		Length = 182 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/love_me_as_though_no_tomorrow.wav",
		Length = 154 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/mad_about_the_boy.wav",
		Length = 128 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/manhattan.wav",
		Length = 81 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/sit_and_dream.wav",
		Length = 89 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/slow_bounce.wav",
		Length = 124 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/somethings_gotta_give.wav",
		Length = 121 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/stars_of_the_midnight_range.wav",
		Length = 172 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/strahlende_trompete.wav",
		Length = 186 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/von_spanien_nach_s_damerika.wav",
		Length = 145 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/where_have_you_been_all_my_life.wav",
		Length = 176 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/nvr/why_dont_you_do_right.wav",
		Length = 202 --length of song in seconds
	}
}

local MRadioStation7 = { --music to be played through radio
	{
		Path = "tss_audio_radio/stations/violin/violin_noodling_01.wav",
		Length = 83 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_noodling_02.wav",
		Length = 83 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_noodling_03.wav",
		Length = 82 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_noodling_04.wav",
		Length = 60 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_noodling_05.wav",
		Length = 78 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_noodling_06.wav",
		Length = 43 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_partitano3gigue_bach.wav",
		Length = 111 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_partitano3p_bach.wav",
		Length = 225 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_sonatano2grave_bach.wav",
		Length = 256 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_vc_1stmov_dvorak.wav",
		Length = 384 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_vc_2ndmov_dvorak.wav",
		Length = 315 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/violin/violin_z_sarasate.wav",
		Length = 315 --length of song in seconds
	}
}

local MRadioStation8 = { --music to be played through radio
	{
		Path = "tss_audio_radio/stations/ulr/concerto_for_2_vl_str_in_d_minor.wav",
		Length = 415 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/ulr/concerto_grosso_in_b_minor_allegro_01.wav",
		Length = 255 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/ulr/concerto_grosso_in_b_minor_allegro_02.wav",
		Length = 214 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/ulr/flower_duet_lakm_kpm.wav",
		Length = 90 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/ulr/four_seasons_no_4_the_winter.wav",
		Length = 141 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/ulr/piano_concerto_no_21__elvira_madigan.wav",
		Length = 337 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/ulr/ride_of_the_valkyries_01.wav",
		Length = 359 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/ulr/spring_song_kpmc.wav",
		Length = 163 --length of song in seconds
	}
}

local MRadioStation9 = { --music to be played through radio
	{
		Path = "tss_audio_radio/stations/beacon/beacon.wav",
		Length = 8 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_kb.wav",
		Length = 7 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_lp.wav",
		Length = 8 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_oz.wav",
		Length = 9 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_al.wav",
		Length = 7 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_ef.wav",
		Length = 7 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_ot.wav",
		Length = 7 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_sr.wav",
		Length = 7 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_yb.wav",
		Length = 9 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_sv.wav",
		Length = 7 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_pn.wav",
		Length = 7 --length of song in seconds
	},
	{
		Path = "tss_audio_radio/stations/beacon/beacon_header.wav",
		Length = 6 --length of song in seconds
	}
}

local RadioToggleSound = {
	"tss_audio_radio/radio_toggle_a.wav",
	"tss_audio_radio/radio_toggle_b.wav",
	"tss_audio_radio/radio_toggle_c.wav"
}

local RadioOnSound = {
	"tss_audio_radio/radio_on_a.wav",
	"tss_audio_radio/radio_on_b.wav"
}

local RadioOffSound = {
	"tss_audio_radio/radio_off_a.wav",
	"tss_audio_radio/radio_off_b.wav"
}

local RadioUseSound = "tss_audio_radio/radio_toggle.wav"

local RadioNullSound = "common/NULL.wav"

function ENT:Initialize()
	
	local RadioModel = {
		"models/props_lab/citizenradio.mdl",
		"models/props/cs_italy/radio_wooden.mdl",
		"models/props/cs_office/radio.mdl"
	}
	self:SetModel(RadioModel[2]) --math.random(3)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:DrawShadow(true)
	--self:SetAngles(Angle(0,math.random(-180,180),0))
    local phys = self:GetPhysicsObject()
	if(IsValid(phys)) then
		phys:Wake()
		phys:SetMass(100)
	end
	self.Engine = NULL
end

function ENT:SpawnFunction(ply,tr,class)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create(class)
	ent:SetPos(SpawnPos)
	ent:SetAngles(Angle(0,math.NormalizeAngle(((ply:EyeAngles()).y)+180),0))
	ent:Spawn()
	ent:Activate()
	return ent
end

--decide what happens when object is used
function ENT:Use(activator,caller)
	self:EmitSound(RadioUseSound,50,100,1,CHAN_AUTO) --play toggle sound
	if (self:GetVar("RadioState",false)) then --toggle radio state
		if (self:GetVar("RadioStation",1) < 9) then
			self:SetVar("RadioStation",self:GetVar("RadioStation",1)+1)
			self:EmitSound(RadioToggleSound[math.random(#RadioToggleSound)],100,100,1,CHAN_AUTO)
			self:EmitSound(RadioNullSound,75,100,1,CHAN_VOICE2)
		else
			self:SetVar("RadioState",false)
			self:SetVar("RadioStation",1)
			self:EmitSound(RadioOffSound[math.random(#RadioOffSound)],100,100,1,CHAN_AUTO)
			self:EmitSound(RadioNullSound,100,100,1,CHAN_VOICE2)
		end
	elseif (!self:GetVar("RadioState",false)) then
		self:SetVar("RadioState",true)
		self:EmitSound(RadioOnSound[math.random(#RadioOnSound)],100,100,1,CHAN_AUTO)
	end
	print(self:GetVar("RadioStation",1)) --WIP
end

local songdata = {}
songdata.Begin = 0
songdata.End = 0
songdata.Path = ""
function ENT:Think()
	local RadioSong
	if (self:GetVar("RadioState",false)) then
		for id, ent in pairs( ents.FindByClass( "tss_point_radio_tower" ) ) do
			if !(self:GetVar("songdata", songdata) == ent:GetSongData(self:GetVar("RadioStation",1))) then
				self:SetVar("songdata", ent:GetSongData(self:GetVar("RadioStation",1)) )
				
				if self:GetVar("RadioStation",1) == self:GetVar("RadioStationOld",0) then
					self:EmitSound(self:GetVar("songdata", songdata).Path,70,100,1,CHAN_VOICE2)
					print("play")
				else
					self:SetVar("RadioStationOld",self:GetVar("RadioStation",1))
				end

				--self:SetNWInt("songdatabegin", songdata.Begin ) --WIP
				--self:SetNWInt("songdataend", songdata.End )
				--self:SetNWString("songdatapath", songdata.Path )
				
			end
		end
	end
end

function ENT:OnRemove()
	self:SetVar("RadioState",false)
	self:EmitSound(RadioNullSound,75,100,1,CHAN_VOICE2)
end