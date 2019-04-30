--execute files
include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()
end

--Radio Station Song Library

--MRadioStation1 
Sound("tss_audio_radio/stations/vault/vault_01.wav")
Sound("tss_audio_radio/stations/vault/vault_02.wav")
Sound("tss_audio_radio/stations/vault/vault_03.wav")
Sound("tss_audio_radio/stations/vault/vault_04.wav")
Sound("tss_audio_radio/stations/vault/vault_05.wav")
Sound("tss_audio_radio/stations/vault/vault_06.wav")

--MRadioStation2
Sound("tss_audio_radio/stations/mbr/blues_for_you.wav")
Sound("tss_audio_radio/stations/mbr/jazz_blues_gt.wav")
Sound("tss_audio_radio/stations/mbr/jazz_club_blues_cas.wav")
Sound("tss_audio_radio/stations/mbr/joe_cool_cas.wav")
Sound("tss_audio_radio/stations/mbr/manhattan.wav")
Sound("tss_audio_radio/stations/mbr/sleepy_town_blues_cas.wav")
Sound("tss_audio_radio/stations/mbr/slow_bounce.wav")
Sound("tss_audio_radio/stations/mbr/slow_sax_kos.wav")
Sound("tss_audio_radio/stations/mbr/why_dont_you_do_right.wav")

--MRadioStation3
Sound("tss_audio_radio/stations/enclave/enclave_america.wav")
Sound("tss_audio_radio/stations/enclave/enclave_battlehymn.wav")
Sound("tss_audio_radio/stations/enclave/enclave_dixie.wav")
Sound("tss_audio_radio/stations/enclave/enclave_montezuma.wav")
Sound("tss_audio_radio/stations/enclave/enclave_presidential.wav")
Sound("tss_audio_radio/stations/enclave/enclave_stars.wav")
Sound("tss_audio_radio/stations/enclave/enclave_washington.wav")
Sound("tss_audio_radio/stations/enclave/enclave_yankee.wav")
Sound("tss_audio_radio/stations/enclave/march_washingtonpost.wav")

--MRadioStation4
Sound("tss_audio_radio/stations/mmr/big_iron.wav")
Sound("tss_audio_radio/stations/mmr/eddyarnold_rca_itsasin.wav")
Sound("tss_audio_radio/stations/mmr/goin_under.wav")
Sound("tss_audio_radio/stations/mmr/happy_times.wav")
Sound("tss_audio_radio/stations/mmr/heartaches_by_the_number.wav")
Sound("tss_audio_radio/stations/mmr/i_m_movin_out.wav")
Sound("tss_audio_radio/stations/mmr/i_m_so_blue.wav")
Sound("tss_audio_radio/stations/mmr/in_the_shadow_of_the_valley.wav")
Sound("tss_audio_radio/stations/mmr/its_a_sin_to_tell_a_lie.wav")
Sound("tss_audio_radio/stations/mmr/johnny_guitar.wav")
Sound("tss_audio_radio/stations/mmr/lazy_day_blues.wav")
Sound("tss_audio_radio/stations/mmr/let_s_ride_into_the_sunset_together.wav")
Sound("tss_audio_radio/stations/mmr/lone_star.wav")
Sound("tss_audio_radio/stations/mmr/roundhouse_rock.wav")
Sound("tss_audio_radio/stations/mmr/stars_of_the_midnight_range.wav")

--MRadioStation5
Sound("tss_audio_radio/stations/gnr/billieholiday_crazy.wav")
Sound("tss_audio_radio/stations/gnr/billieholiday_easy.wav")
Sound("tss_audio_radio/stations/gnr/bobcrosby_happy.wav")
Sound("tss_audio_radio/stations/gnr/bobcrosby_way.wav")
Sound("tss_audio_radio/stations/gnr/coleporter_anything.wav")
Sound("tss_audio_radio/stations/gnr/dannykaye_civilization.wav")
Sound("tss_audio_radio/stations/gnr/ellafitzgerald_into.wav")
Sound("tss_audio_radio/stations/gnr/generic_boogie.wav")
Sound("tss_audio_radio/stations/gnr/generic_fox.wav")
Sound("tss_audio_radio/stations/gnr/generic_jazzy.wav")
Sound("tss_audio_radio/stations/gnr/generic_jolly.wav")
Sound("tss_audio_radio/stations/gnr/generic_pink.wav")
Sound("tss_audio_radio/stations/gnr/generic_rhythm.wav")
Sound("tss_audio_radio/stations/gnr/generic_sunning.wav")
Sound("tss_audio_radio/stations/gnr/generic_swing.wav")
Sound("tss_audio_radio/stations/gnr/inkspots_idont.wav")
Sound("tss_audio_radio/stations/gnr/inkspots_maybe.wav")
Sound("tss_audio_radio/stations/gnr/roybrown_butcher.wav")
Sound("tss_audio_radio/stations/gnr/roybrown_mighty.wav")
Sound("tss_audio_radio/stations/gnr/texbeneke_guy.wav")

--MRadioStation6
Sound("tss_audio_radio/stations/nvr/aint_that_a_kick_in_the_head.wav")
Sound("tss_audio_radio/stations/nvr/american_swing.wav")
Sound("tss_audio_radio/stations/nvr/big_iron.wav")
Sound("tss_audio_radio/stations/nvr/blue_moon.wav")
Sound("tss_audio_radio/stations/nvr/hallo_mister_x.wav")
Sound("tss_audio_radio/stations/nvr/heartaches_by_the_number.wav")
Sound("tss_audio_radio/stations/nvr/its_a_sin_to_tell_a_lie.wav")
Sound("tss_audio_radio/stations/nvr/jingle_jangle_jingle.wav")
Sound("tss_audio_radio/stations/nvr/johnny_guitar.wav")
Sound("tss_audio_radio/stations/nvr/love_me_as_though_no_tomorrow.wav")
Sound("tss_audio_radio/stations/nvr/mad_about_the_boy.wav")
Sound("tss_audio_radio/stations/nvr/manhattan.wav")
Sound("tss_audio_radio/stations/nvr/sit_and_dream.wav")
Sound("tss_audio_radio/stations/nvr/slow_bounce.wav")
Sound("tss_audio_radio/stations/nvr/somethings_gotta_give.wav")
Sound("tss_audio_radio/stations/nvr/stars_of_the_midnight_range.wav")
Sound("tss_audio_radio/stations/nvr/strahlende_trompete.wav")
Sound("tss_audio_radio/stations/nvr/von_spanien_nach_s_damerika.wav")
Sound("tss_audio_radio/stations/nvr/where_have_you_been_all_my_life.wav")
Sound("tss_audio_radio/stations/nvr/why_dont_you_do_right.wav")

--MRadioStation7
Sound("tss_audio_radio/stations/violin/violin_noodling_01.wav")
Sound("tss_audio_radio/stations/violin/violin_noodling_02.wav")
Sound("tss_audio_radio/stations/violin/violin_noodling_03.wav")
Sound("tss_audio_radio/stations/violin/violin_noodling_04.wav")
Sound("tss_audio_radio/stations/violin/violin_noodling_05.wav")
Sound("tss_audio_radio/stations/violin/violin_noodling_06.wav")
Sound("tss_audio_radio/stations/violin/violin_partitano3gigue_bach.wav")
Sound("tss_audio_radio/stations/violin/violin_partitano3p_bach.wav")
Sound("tss_audio_radio/stations/violin/violin_sonatano2grave_bach.wav")
Sound("tss_audio_radio/stations/violin/violin_vc_1stmov_dvorak.wav")
Sound("tss_audio_radio/stations/violin/violin_vc_2ndmov_dvorak.wav")
Sound("tss_audio_radio/stations/violin/violin_z_sarasate.wav")

--MRadioStation8
Sound("tss_audio_radio/stations/ulr/concerto_for_2_vl_str_in_d_minor.wav")
Sound("tss_audio_radio/stations/ulr/concerto_grosso_in_b_minor_allegro_01.wav")
Sound("tss_audio_radio/stations/ulr/concerto_grosso_in_b_minor_allegro_02.wav")
Sound("tss_audio_radio/stations/ulr/flower_duet_lakm_kpm.wav")
Sound("tss_audio_radio/stations/ulr/four_seasons_no_4_the_winter.wav")
Sound("tss_audio_radio/stations/ulr/piano_concerto_no_21__elvira_madigan.wav")
Sound("tss_audio_radio/stations/ulr/ride_of_the_valkyries_01.wav")
Sound("tss_audio_radio/stations/ulr/spring_song_kpmc.wav")

--MRadioStation9
Sound("tss_audio_radio/stations/beacon/beacon.wav")
Sound("tss_audio_radio/stations/beacon/beacon_kb.wav")
Sound("tss_audio_radio/stations/beacon/beacon_lp.wav")
Sound("tss_audio_radio/stations/beacon/beacon_oz.wav")
Sound("tss_audio_radio/stations/beacon/beacon_al.wav")
Sound("tss_audio_radio/stations/beacon/beacon_ef.wav")
Sound("tss_audio_radio/stations/beacon/beacon_ot.wav")
Sound("tss_audio_radio/stations/beacon/beacon_sr.wav")
Sound("tss_audio_radio/stations/beacon/beacon_yb.wav")
Sound("tss_audio_radio/stations/beacon/beacon_sv.wav")
Sound("tss_audio_radio/stations/beacon/beacon_pn.wav")
Sound("tss_audio_radio/stations/beacon/beacon_header.wav")

--RadioToggleSound
Sound("tss_audio_radio/radio_toggle_a.wav")
Sound("tss_audio_radio/radio_toggle_b.wav")
Sound("tss_audio_radio/radio_toggle_c.wav")

--RadioOnSound
Sound("tss_audio_radio/radio_on_a.wav")
Sound("tss_audio_radio/radio_on_b.wav")

--RadioOffSound
Sound("tss_audio_radio/radio_off_a.wav")
Sound("tss_audio_radio/radio_off_b.wav")

--RadioUseSound
Sound("tss_audio_radio/radio_toggle.wav")

--RadioNullSound
Sound("common/NULL.wav")

/*
local svsongdata = {}
local clsongdata = {}
local sound

function ENT:Think()
	svsongdata.End = self:GetNWInt( "songdataend", 0 )
	svsongdata.Begin = self:GetNWInt( "songdatabegin", 0 )
	svsongdata.Path = self:GetNWString( "songdatapath", "" )
	if !(svsongdata==clsongdata) then
		clsongdata = svsongdata
		print(clsongdata.Begin.." "..clsongdata.End.." "..clsongdata.Path)
		sound.PlayFile("sound/"..clsongdata.Path,"3d noblock",PlayStation)
	end
end

function PlayStation(station,errorid,errorname)
	--if IsValid(station) then 
		station:SetTime(CurTime() - clsongdata.Begin)
		station:Play()
		sound = station
	--end
		print(errorid)
		print(errorname)
		print(clsongdata.Path)
end
*/