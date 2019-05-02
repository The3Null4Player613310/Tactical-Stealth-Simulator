--menus


--Main Menu
function MainMenu() --WIP
	--Main Frame
	FrmMainMenu = vgui.Create("DFrame")
	FrmMainMenu:SetSize(ScrW(),ScrH())
	FrmMainMenu:Center()
	FrmMainMenu:SetDraggable(false)
	FrmMainMenu:SetSizable(false)
	FrmMainMenu:SetScreenLock(true)
	FrmMainMenu:ShowCloseButton(false)
	FrmMainMenu:SetTitle("Main Menu")
	FrmMainMenu:MakePopup()
	
		
	if game.SinglePlayer() or true then
	
		FrmMainMenu_PnlGameList = vgui.Create("DPanel",FrmMainMenu)
		FrmMainMenu_PnlGameList:SetPos(0,0)
		FrmMainMenu_PnlGameList:SetSize(FrmMainMenu:GetWide()*0.25,FrmMainMenu:GetTall())
		
			FrmMainMenu_PnlGameList_LslGameList = vgui.Create( "DListLayout", FrmMainMenu_PnlGameList )
			FrmMainMenu_PnlGameList_LslGameList:SetSize(FrmMainMenu_PnlGameList:GetWide(),FrmMainMenu_PnlGameList:GetTall())
			FrmMainMenu_PnlGameList_LslGameList:SetPos(0,0)
			FrmMainMenu_PnlGameList_LslGameList:MakeDroppable( "unique_name" ) 

				FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer = vgui.Create("DCollapsibleCategory",FrmMainMenu_PnlGameList_LslGameList)
				FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer:SetPos(0,0)
				FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer:SetSize(FrmMainMenu_PnlGameList_LslGameList:GetWide(),FrmMainMenu_PnlGameList_LslGameList:GetTall()*0.50)
				FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer:SetExpanded(false)
				FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer:SetLabel("SinglePlayer")

					FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer_LstSinglePlayer = vgui.Create("DPanelList",FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer)
					FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer_LstSinglePlayer:SetSpacing(5)
					FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer_LstSinglePlayer:SetPadding( 5 )
					FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer_LstSinglePlayer:EnableHorizontal(false)
					FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer_LstSinglePlayer:EnableVerticalScrollbar(true)
					FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer:SetContents(FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer_LstSinglePlayer)
					
					for i = 1, 32 do
							FrmMainMenu_PnlGameList_LslGameList_CatSinglePlayer_LstSinglePlayer:AddItem( Label( " Label " .. i ) )
					end
				
				FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer = vgui.Create("DCollapsibleCategory",FrmMainMenu_PnlGameList_LslGameList)
				FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer:SetPos(0,0)
				FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer:SetSize(FrmMainMenu_PnlGameList_LslGameList:GetWide(),FrmMainMenu_PnlGameList_LslGameList:GetTall()*0.50)
				FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer:SetExpanded(false)
				FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer:SetLabel("MultiPlayer")

					FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer_LstMultiPlayer = vgui.Create("DPanelList",FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer)
					FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer_LstMultiPlayer:SetSpacing(5)
					FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer_LstMultiPlayer:EnableHorizontal(false)
					FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer_LstMultiPlayer:EnableVerticalScrollbar(true)
					FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer:SetContents(FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer_LstMultiPlayer)
					
						for i = 1, 32 do
							FrmMainMenu_PnlGameList_LslGameList_CatMultiPlayer_LstMultiPlayer:AddItem( Label( " Label " .. i ) )
						end
		
		FrmMainMenu_PnlGameSettings = vgui.Create("DPanel",FrmMainMenu)
		FrmMainMenu_PnlGameSettings:SetPos(FrmMainMenu:GetWide()*0.25,0)
		FrmMainMenu_PnlGameSettings:SetSize(FrmMainMenu:GetWide()*0.50,FrmMainMenu:GetTall())
		
	else
	
		FrmMainMenu_PnlLeftAd = vgui.Create("DPanel",FrmMainMenu)
		FrmMainMenu_PnlLeftAd:SetPos(0,0)
		FrmMainMenu_PnlLeftAd:SetSize(FrmMainMenu:GetWide()*0.25,FrmMainMenu:GetTall())
		
		FrmMainMenu_PnlGameDetails = vgui.Create("DPanel",FrmMainMenu)
		FrmMainMenu_PnlGameDetails:SetPos(0,0)
		FrmMainMenu_PnlGameDetails:SetSize(FrmMainMenu:GetWide()*0.75,FrmMainMenu:GetTall())
	
	end
		
	if game.SinglePlayer() then
	
		FrmMainMenu_PnlRightAd = vgui.Create("DPanel",FrmMainMenu)
		FrmMainMenu_PnlRightAd:SetPos(FrmMainMenu:GetWide()*0.75,0)
		FrmMainMenu_PnlRightAd:SetSize(FrmMainMenu:GetWide()*0.25,FrmMainMenu:GetTall())
	
	else
		
		FrmMainMenu_PnlPlayerList = vgui.Create("DPanel",FrmMainMenu)
		FrmMainMenu_PnlPlayerList:SetPos(FrmMainMenu:GetWide()*0.75,0)
		FrmMainMenu_PnlPlayerList:SetSize(FrmMainMenu:GetWide()*0.25,FrmMainMenu:GetTall()*0.85)
		
			FrmMainMenu_PnlPlayerList_GrdPlayerList = vgui.Create("DGrid",FrmMainMenu_PnlPlayerList)
			FrmMainMenu_PnlPlayerList_GrdPlayerList:SetPos(FrmMainMenu_PnlPlayerList:GetWide()*0.05,FrmMainMenu_PnlPlayerList:GetWide()*0.05)
			FrmMainMenu_PnlPlayerList_GrdPlayerList:SetCols(1)
			FrmMainMenu_PnlPlayerList_GrdPlayerList:SetColWide(FrmMainMenu_PnlPlayerList:GetWide()*0.90)
				
				MainMenuPopulatePlayerList()
	
		FrmMainMenu_PnlPlayerStats = vgui.Create("DPanel",FrmMainMenu)
		FrmMainMenu_PnlPlayerStats:SetPos(FrmMainMenu:GetWide()*0.75,FrmMainMenu:GetTall()*0.85)
		FrmMainMenu_PnlPlayerStats:SetSize(FrmMainMenu:GetWide()*0.25,FrmMainMenu:GetTall()*0.15)
	
			FrmMainMenu_PnlPlayerStats_ImgPlayerAvatar = vgui.Create("AvatarImage",FrmMainMenu_PnlPlayerStats)
			FrmMainMenu_PnlPlayerStats_ImgPlayerAvatar:SetSize(FrmMainMenu_PnlPlayerStats:GetTall()*0.90,FrmMainMenu_PnlPlayerStats:GetTall()*0.90)
			FrmMainMenu_PnlPlayerStats_ImgPlayerAvatar:SetPos(FrmMainMenu_PnlPlayerStats:GetTall()*0.05,FrmMainMenu_PnlPlayerStats:GetTall()*0.05)
			FrmMainMenu_PnlPlayerStats_ImgPlayerAvatar:SetPlayer(LocalPlayer(),184)
			
			FrmMainMenu_PnlPlayerStats_LblPlayerName = vgui.Create("DLabelURL",FrmMainMenu_PnlPlayerStats)
			FrmMainMenu_PnlPlayerStats_LblPlayerName:SetPos(FrmMainMenu_PnlPlayerStats:GetTall(),FrmMainMenu_PnlPlayerStats:GetTall()*0.05)
			FrmMainMenu_PnlPlayerStats_LblPlayerName:SetSize((FrmMainMenu_PnlPlayerStats:GetWide())-(FrmMainMenu_PnlPlayerStats:GetTall())-(FrmMainMenu_PnlPlayerStats:GetTall()*0.05), FrmMainMenu_PnlPlayerStats:GetTall()*0.90 )
			FrmMainMenu_PnlPlayerStats_LblPlayerName:SetColor( Color( 0, 0, 0, 255 ) )
			FrmMainMenu_PnlPlayerStats_LblPlayerName:SetText( LocalPlayer():Name() )
			FrmMainMenu_PnlPlayerStats_LblPlayerName:SetURL( "http://steamcommunity.com/profiles/" .. LocalPlayer():SteamID64() )
			--could use Player[PlayerID]:ShowProfile() but not needed
	end
	
	--Temp Close Button
	FrmMainMenu_BtnClose = vgui.Create("DButton",FrmMainMenu)
	FrmMainMenu_BtnClose:SetSize(120,60)
	FrmMainMenu_BtnClose:Center()
	FrmMainMenu_BtnClose:SetText("Close")
	FrmMainMenu_BtnClose.DoClick = function()
		FrmMainMenu:Close()
	end
end
concommand.Add("tss_mainmenu",MainMenu)

function MainMenuPopulatePlayerList()
	FrmMainMenu_PnlPlayerList_GrdPlayerList_BtnPlayer = {}
	local Player = player.GetAll()
	for PlayerID = 1,#Player do
		FrmMainMenu_PnlPlayerList_GrdPlayerList_BtnPlayer[PlayerID] = vgui.Create("DButton")
		FrmMainMenu_PnlPlayerList_GrdPlayerList_BtnPlayer[PlayerID]:SetText(Player[PlayerID]:Name())
		FrmMainMenu_PnlPlayerList_GrdPlayerList_BtnPlayer[PlayerID]:SetSize(FrmMainMenu_PnlPlayerList:GetWide()*0.90,FrmMainMenu_PnlPlayerList_GrdPlayerList:GetWide()*0.50)
		FrmMainMenu_PnlPlayerList_GrdPlayerList:AddItem(FrmMainMenu_PnlPlayerList_GrdPlayerList_BtnPlayer[PlayerID])
		FrmMainMenu_PnlPlayerList_GrdPlayerList_BtnPlayer[PlayerID].DoClick = function()
			MainMenuChoosePlayer(Player[PlayerID])
		end
	end
end

function MainMenuChoosePlayer(ply)
	--set player image
	FrmMainMenu_PnlPlayerStats_ImgPlayerAvatar:SetPlayer(ply,184)
	--set player name and link
	FrmMainMenu_PnlPlayerStats_LblPlayerName:SetText(ply:Name())
	if ply:IsBot() then
		FrmMainMenu_PnlPlayerStats_LblPlayerName:SetURL( "http://steamcommunity.com/profiles/")
	else
		FrmMainMenu_PnlPlayerStats_LblPlayerName:SetURL( "http://steamcommunity.com/profiles/" .. ply:SteamID64() )
	end
end

--ScoreBoard
function ScoreBoardOpen()
	--Main Frame
	FrmScoreBoard = vgui.Create("DFrame")
	FrmScoreBoard:SetSize(ScrW()*0.50,ScrH()*0.75)
	FrmScoreBoard:Center()
	FrmScoreBoard:SetDraggable(false)
	FrmScoreBoard:SetSizable(false)
	FrmScoreBoard:SetScreenLock(true)
	FrmScoreBoard:ShowCloseButton(false)
	FrmScoreBoard:SetBackgroundBlur(true)
	FrmScoreBoard:SetTitle("Score Board")
	FrmScoreBoard:MakePopup()
		
		FrmScoreBoard_GrdPlayerList = vgui.Create("DGrid",FrmScoreBoard)
		FrmScoreBoard_GrdPlayerList:SetPos(FrmScoreBoard:GetWide()*0.05,FrmScoreBoard:GetWide()*0.05)
		FrmScoreBoard_GrdPlayerList:SetCols(1)
		FrmScoreBoard_GrdPlayerList:SetColWide(FrmScoreBoard:GetWide()*0.90)
		--FrmScoreBoard_GrdPlayerList:SetRowHeight() -- im not sure how this works yet
		
		ScoreBoardPopulatePlayerList()
		
end

function ScoreBoardPopulatePlayerList()
	FrmScoreBoard_GrdPlayerList_Player = {}
	local Player = player.GetAll()
	for PlayerID = 1,#Player do
		if (Player[PlayerID]:Team() == LocalPlayer():Team()) or (LocalPlayer():Team() == 1) then
			ScoreBoardMakeEntry(Player,PlayerID)
		end
	end
end

function ScoreBoardMakeEntry(Player,PlayerID)
	FrmScoreBoard_GrdPlayerList_Player[PlayerID] = {}
	FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain = vgui.Create("DPanel")
	FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain:SetSize(FrmScoreBoard:GetWide()*0.90,FrmScoreBoard_GrdPlayerList:GetWide()*0.45)
	FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain:SetBackgroundColor( Color(Player[PlayerID]:GetPlayerColor().r*255,Player[PlayerID]:GetPlayerColor().g*255,Player[PlayerID]:GetPlayerColor().b*255,200) )
	FrmScoreBoard_GrdPlayerList:AddItem(FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain)
	
		FrmScoreBoard_GrdPlayerList_Player[PlayerID].LblName = vgui.Create( "DLabel", FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain )
		FrmScoreBoard_GrdPlayerList_Player[PlayerID].LblName:SetFont("Trebuchet24") --CenterPrintText
		FrmScoreBoard_GrdPlayerList_Player[PlayerID].LblName:SetText( Player[PlayerID]:Name() )
		FrmScoreBoard_GrdPlayerList_Player[PlayerID].LblName:SizeToContents()
		FrmScoreBoard_GrdPlayerList_Player[PlayerID].LblName:Center()
		
		FrmScoreBoard_GrdPlayerList_Player[PlayerID].ImgAvatar = vgui.Create( "AvatarImage", FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain )
		FrmScoreBoard_GrdPlayerList_Player[PlayerID].ImgAvatar:SetSize( FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain:GetTall()*0.90, FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain:GetTall()*0.90 )
		FrmScoreBoard_GrdPlayerList_Player[PlayerID].ImgAvatar:SetPos( FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain:GetWide()-(FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain:GetTall()*1.05), FrmScoreBoard_GrdPlayerList_Player[PlayerID].PnlMain:GetTall()*0.05 )
		FrmScoreBoard_GrdPlayerList_Player[PlayerID].ImgAvatar:SetPlayer( Player[PlayerID], 184 )
	
end

function ScoreBoardClose()
	FrmScoreBoard:Close()
end