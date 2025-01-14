#Tunga
import app
import net
import ui
import snd
import wndMgr
import musicInfo
import serverInfo
import systemSetting
import ServerStateChecker
import localeInfo
import constInfo
import uiCommon
import ime
import uiScriptLocale
import time
import dbg
import os
import servercommandparser
RegisteredID = ""
RegisteredPassword = ""

class ConnectingDialog(ui.ScriptWindow):

	def __init__(self):
		ui.ScriptWindow.__init__(self)
		self.SetWindowName("ConnectingDialog")
		self.__LoadDialog()
		self.eventTimeOver = lambda *arg: None
		self.eventExit = lambda *arg: None

	def __del__(self):
		ui.ScriptWindow.__del__(self)

	def __LoadDialog(self):
		try:
			PythonScriptLoader = ui.PythonScriptLoader()
			PythonScriptLoader.LoadScriptFile(self, "UIScript/ConnectingDialog.py")

			self.board = self.GetChild("board")
			self.message = self.GetChild("message")
			self.countdownMessage = self.GetChild("countdown_message")

		except:
			import exception
			exception.Abort("ConnectingDialog.LoadDialog.BindObject")

	def Open(self, waitTime):
		curTime = time.clock()
		self.endTime = curTime + waitTime

		self.Lock()
		self.SetCenterPosition()
		self.SetTop()
		self.Show()

	def Close(self):
		self.Unlock()
		self.ClearDictionary()
		self.Hide()

	def Destroy(self):
		self.Hide()
		self.ClearDictionary()

	def SetText(self, text):
		self.message.SetText(text)

	def SetCountDownMessage(self, waitTime):
		self.countdownMessage.SetText("%.0f%s" % (waitTime, localeInfo.SECOND))

	def SAFE_SetTimeOverEvent(self, event):
		self.eventTimeOver = ui.__mem_func__(event)

	def SAFE_SetExitEvent(self, event):
		self.eventExit = ui.__mem_func__(event)

	def OnUpdate(self):
		lastTime = max(0, self.endTime - time.clock())
		if 0 == lastTime:
			self.Close()
			self.eventTimeOver()
		else:
			self.SetCountDownMessage(self.endTime - time.clock())

	def OnPressExitKey(self):
		self.eventExit()
		return True

class LoginWindow(ui.ScriptWindow):
	def __init__(self, stream):
		print "LoginWindow::LoginWindow"
		ui.ScriptWindow.__init__(self)
		self.SetWindowName("LoginWindow")
		net.SetPhaseWindow(net.PHASE_WINDOW_LOGIN, self)
		net.SetAccountConnectorHandler(self)

		self.connectingDialog = None
		self.stream=stream
		self.isNowCountDown=False



	def __del__(self):
		print "LoginWindow::~LoginWindow"
		net.SetAccountConnectorHandler(0)
		net.ClearPhaseWindow(net.PHASE_WINDOW_LOGIN, self)
		ui.ScriptWindow.__del__(self)

	def Open(self):
		ServerStateChecker.Create(self)

		print "LoginWindow::Open()"
		self.loginFailureMsgDict={
			"ALREADY"	: localeInfo.LOGIN_FAILURE_ALREAY,
			"NOID"		: localeInfo.LOGIN_FAILURE_NOT_EXIST_ID,
			"WRONGPWD"	: localeInfo.LOGIN_FAILURE_WRONG_PASSWORD,
			"FULL"		: localeInfo.LOGIN_FAILURE_TOO_MANY_USER,
			"SHUTDOWN"	: localeInfo.LOGIN_FAILURE_SHUTDOWN,
			"REPAIR"	: localeInfo.LOGIN_FAILURE_REPAIR_ID,
			"BLOCK"		: localeInfo.LOGIN_FAILURE_BLOCK_ID,
			"BESAMEKEY"	: localeInfo.LOGIN_FAILURE_BE_SAME_KEY,
			"NOTAVAIL"	: localeInfo.LOGIN_FAILURE_NOT_AVAIL,
			"NOBILL"	: localeInfo.LOGIN_FAILURE_NOBILL,
			"BLKLOGIN"	: localeInfo.LOGIN_FAILURE_BLOCK_LOGIN,
			"WEBBLK"	: localeInfo.LOGIN_FAILURE_WEB_BLOCK,
		}

		self.loginFailureFuncDict = {
			"WRONGPWD"	: self.__DisconnectAndInputPassword,
			"QUIT"		: app.Exit,
		}

		self.SetSize(wndMgr.GetScreenWidth(), wndMgr.GetScreenHeight())

		if not self.__LoadScript("UIScript/LoginWindow.py"):
			dbg.TraceError("LoginWindow.Open - __LoadScript Error")
			return

		self.__LoadLoginInfo("loginInfo.xml")
		if app.loggined:
			self.loginFailureFuncDict = {
			"WRONGPWD"	: app.Exit,
			"WRONGMAT"	: app.Exit,
			"QUIT"		: app.Exit,
			}

		if musicInfo.loginMusic:
			snd.SetMusicVolume(systemSetting.GetMusicVolume())
			snd.FadeInMusic("BGM/"+musicInfo.loginMusic)

		snd.SetSoundVolume(systemSetting.GetSoundVolume())

		ime.AddExceptKey(91)
		ime.AddExceptKey(93)
		self.Show()

		self.__RefreshServerList()
		self.__OpenLoginBoard()


		app.ShowCursor()

	def Close(self):
		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		ServerStateChecker.Initialize(self)
		print "---------------------------------------------------------------------------- CLOSE LOGIN WINDOW "

		if musicInfo.loginMusic != "" and musicInfo.selectMusic != "":
			snd.FadeOutMusic("BGM/"+musicInfo.loginMusic)

		self.idEditLine.SetTabEvent(0)
		self.idEditLine.SetReturnEvent(0)
		self.pwdEditLine.SetReturnEvent(0)
		self.pwdEditLine.SetTabEvent(0)

		self.loginBoard = None
		self.idEditLine = None
		self.pwdEditLine = None
		self.connectingDialog = None

		self.serverList = None

		self.KillFocus()
		self.Hide()

		self.stream.popupWindow.Close()
		self.loginFailureFuncDict=None
		ime.ClearExceptKey()
		app.HideCursor()




	def __ExitGame(self):
		app.Exit()

	def SetIDEditLineFocus(self):
		if self.idEditLine != None:
			self.idEditLine.SetFocus()

	def SetPasswordEditLineFocus(self):
		if self.pwdEditLine != None:
			self.pwdEditLine.SetFocus()


	def OnEndCountDown(self):
		self.isNowCountDown = False
		self.OnConnectFailure()

	def OnConnectFailure(self):

		if self.isNowCountDown:
			return

		snd.PlaySound("sound/ui/loginfail.wav")

		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		if app.loggined:
			self.PopupNotifyMessage(localeInfo.LOGIN_CONNECT_FAILURE, self.__ExitGame)
		else:
			self.PopupNotifyMessage(localeInfo.LOGIN_CONNECT_FAILURE, self.SetPasswordEditLineFocus)

	def OnHandShake(self):
		snd.PlaySound("sound/ui/loginok.wav")
		self.PopupDisplayMessage(localeInfo.LOGIN_CONNECT_SUCCESS)
		constInfo.ACCOUNT_NAME = str(self.idEditLine.GetText())

	def OnLoginStart(self):
		self.PopupDisplayMessage(localeInfo.LOGIN_PROCESSING)

	def OnLoginFailure(self, error):
		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		try:
			loginFailureMsg = self.loginFailureMsgDict[error]
		except KeyError:
			loginFailureMsg = localeInfo.LOGIN_FAILURE_UNKNOWN  + error

		loginFailureFunc=self.loginFailureFuncDict.get(error, self.SetPasswordEditLineFocus)
		if app.loggined:
			self.PopupNotifyMessage(loginFailureMsg, self.__ExitGame)
		else:
			self.PopupNotifyMessage(loginFailureMsg, loginFailureFunc)

		snd.PlaySound("sound/ui/loginfail.wav")

	def __DisconnectAndInputID(self):
		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		self.SetIDEditLineFocus()
		net.Disconnect()

	def __DisconnectAndInputPassword(self):
		if self.connectingDialog:
			self.connectingDialog.Close()
		self.connectingDialog = None

		self.SetPasswordEditLineFocus()
		net.Disconnect()

	def __LoadScript(self, fileName):
		try:
			pyScrLoader = ui.PythonScriptLoader()
			pyScrLoader.LoadScriptFile(self, fileName)
		except:
			import exception
			exception.Abort("LoginWindow.__LoadScript.LoadObject")

		try:
			GetObject=self.GetChild
			self.serverList				= GetObject("ServerList")
			self.loginBoard				= GetObject("LoginBoard")
			self.idEditLine				= GetObject("ID_EditLine")
			self.pwdEditLine			= GetObject("Password_EditLine")
			self.loginButton			= GetObject("LoginButton")
			self.loginExitButton		= GetObject("LoginExitButton")

			self.ChannelButton1			= GetObject("ChannelButton1")
			self.ChannelButton2			= GetObject("ChannelButton2")
			self.ChannelButton3			= GetObject("ChannelButton3")
			self.ChannelButton4			= GetObject("ChannelButton4")

			self.ChannelButtonTooltip1	= GetObject("ChannelButtonTooltip1")
			self.ChannelButtonTooltip2	= GetObject("ChannelButtonTooltip2")
			self.ChannelButtonTooltip3	= GetObject("ChannelButtonTooltip3")
			self.ChannelButtonTooltip4	= GetObject("ChannelButtonTooltip4")

			self.passwordrestart		= GetObject("passwordresetbutton")
			self.facebookbutton			= GetObject("facebook")
			self.instagrambutton		= GetObject("instagram")
			self.discordbutton			= GetObject("discord")
			self.youtubebutton			= GetObject("youtube")

			self.registerButton1		= GetObject("registerButton1")
			self.registerButton2		= GetObject("registerButton2")
			self.registerButton3		= GetObject("registerButton3")
			self.registerButton4		= GetObject("registerButton4")
			self.registerButton5		= GetObject("registerButton5")
			self.registerButton6		= GetObject("registerButton6")
			self.registerButtons		= { 1 : self.registerButton1, 2 : self.registerButton2, 3 : self.registerButton3, 4 : self.registerButton4 , 5 : self.registerButton5 , 6 : self.registerButton6 }

			self.deleteButton1			= GetObject("deleteButton1")
			self.deleteButton2			= GetObject("deleteButton2")
			self.deleteButton3			= GetObject("deleteButton3")
			self.deleteButton4			= GetObject("deleteButton4")
			self.deleteButton5			= GetObject("deleteButton5")
			self.deleteButton6			= GetObject("deleteButton6")

			self.OnClickChangeTr		= GetObject("ChangeLanguageTr")
			self.OnClickChangeEn		= GetObject("ChangeLanguageEn")
			self.OnClickChangeDe		= GetObject("ChangeLanguageDe")
			self.OnClickChangePt		= GetObject("ChangeLanguagePt")
			self.OnClickChangeRo		= GetObject("ChangeLanguageRo")
			self.OnClickChangeEs		= GetObject("ChangeLanguageEs")
			self.OnClickChangeHu		= GetObject("ChangeLanguageHu")
		except:
			import exception
			exception.Abort("LoginWindow.__LoadScript.BindObject")

		self.loginButton.SetEvent(ui.__mem_func__(self.__OnClickLoginButton))
		self.loginExitButton.SetEvent(ui.__mem_func__(self.__OnClickExitButton))
		self.serverList.SetEvent(ui.__mem_func__(self.__OnSelectServer))

		self.idEditLine.SetReturnEvent(ui.__mem_func__(self.pwdEditLine.SetFocus))
		self.idEditLine.SetTabEvent(ui.__mem_func__(self.pwdEditLine.SetFocus))

		self.pwdEditLine.SetReturnEvent(ui.__mem_func__(self.__OnClickLoginButton))
		self.pwdEditLine.SetTabEvent(ui.__mem_func__(self.idEditLine.SetFocus))

		self.ChannelButton1.SetEvent(ui.__mem_func__(self.__SelectChannel), 1)
		self.ChannelButton2.SetEvent(ui.__mem_func__(self.__SelectChannel), 2)
		self.ChannelButton3.SetEvent(ui.__mem_func__(self.__SelectChannel), 3)
		self.ChannelButton4.SetEvent(ui.__mem_func__(self.__SelectChannel), 4)

		self.passwordrestart.SetEvent(ui.__mem_func__(self.__OnClickPasswordRestart))
		self.facebookbutton.SetEvent(ui.__mem_func__(self.__OnClickFacebook))
		self.instagrambutton.SetEvent(ui.__mem_func__(self.__OnClickinstagram))
		self.youtubebutton.SetEvent(ui.__mem_func__(self.__OnClickYoutube))
		self.discordbutton.SetEvent(ui.__mem_func__(self.__OnClickDiscord))

		self.registerButton1.SetEvent(ui.__mem_func__(self.OnClickRegisterButton), 1)
		self.registerButton2.SetEvent(ui.__mem_func__(self.OnClickRegisterButton), 2)
		self.registerButton3.SetEvent(ui.__mem_func__(self.OnClickRegisterButton), 3)
		self.registerButton4.SetEvent(ui.__mem_func__(self.OnClickRegisterButton), 4)
		self.registerButton5.SetEvent(ui.__mem_func__(self.OnClickRegisterButton), 5)
		self.registerButton6.SetEvent(ui.__mem_func__(self.OnClickRegisterButton), 6)

		self.deleteButton1.SetEvent(ui.__mem_func__(self.__OnClickdeleteButton), 1)
		self.deleteButton2.SetEvent(ui.__mem_func__(self.__OnClickdeleteButton), 2)
		self.deleteButton3.SetEvent(ui.__mem_func__(self.__OnClickdeleteButton), 3)
		self.deleteButton4.SetEvent(ui.__mem_func__(self.__OnClickdeleteButton), 4)
		self.deleteButton5.SetEvent(ui.__mem_func__(self.__OnClickdeleteButton), 5)
		self.deleteButton6.SetEvent(ui.__mem_func__(self.__OnClickdeleteButton), 6)

		self.OnClickChangeTr.SetEvent(ui.__mem_func__(self.__OnClickChangeLanguage), "tr")
		self.OnClickChangeEn.SetEvent(ui.__mem_func__(self.__OnClickChangeLanguage), "en")
		self.OnClickChangeDe.SetEvent(ui.__mem_func__(self.__OnClickChangeLanguage), "de")
		self.OnClickChangePt.SetEvent(ui.__mem_func__(self.__OnClickChangeLanguage), "pt")
		self.OnClickChangeRo.SetEvent(ui.__mem_func__(self.__OnClickChangeLanguage), "ro")
		self.OnClickChangeEs.SetEvent(ui.__mem_func__(self.__OnClickChangeLanguage), "es")
		self.OnClickChangeHu.SetEvent(ui.__mem_func__(self.__OnClickChangeLanguage), "hu")
		return 1


		localeInfo.UI_DEF_FONT = uiDefFontBackup


	def Connect(self, id, pwd):
		self.stream.popupWindow.Close()
		self.stream.popupWindow.Open(localeInfo.LOGIN_CONNETING, self.SetPasswordEditLineFocus, localeInfo.UI_CANCEL)

		self.stream.SetLoginInfo(id, pwd)
		self.stream.Connect()

	def __OnClickExitButton(self):
		self.stream.SetPhaseWindow(0)

	def __SetServerInfo(self, name):
		net.SetServerInfo(name.strip())
		self.serverInfo.SetText(name)

	def __LoadLoginInfo(self, loginInfoFileName):
		def getValue(element, name, default):
			if [] != element.getElementsByTagName(name):
				return element.getElementsByTagName(name).item(0).firstChild.nodeValue
			else:
				return default


		self.id = None
		self.pwd = None
		self.loginnedServer = None
		self.loginnedChannel = None
		app.loggined = False

		self.loginInfo = True
		try:
			server_name = logininfo.getAttribute("name")
			channel_idx = int(logininfo.getAttribute("channel_idx"))
		except:
			return

		try:
			matched = False

			for k, v in serverInfo.REGION_DICT[0].iteritems():
				if v["name"] == server_name:
					account_addr = serverInfo.REGION_AUTH_SERVER_DICT[0][k]["ip"]
					account_port = serverInfo.REGION_AUTH_SERVER_DICT[0][k]["port"]

					channel_info = v["channel"][channel_idx]
					channel_name = channel_info["name"]
					addr = channel_info["ip"]
					port = channel_info["tcp_port"]

					net.SetMarkServer(addr, port)
					self.stream.SetConnectInfo(addr, port, account_addr, account_port)

					matched = True
					break

			if False == matched:
				return
		except:
			return

		self.__SetServerInfo("%s, %s " % (server_name, channel_name))
		id = getValue(logininfo, "id", "")
		pwd = getValue(logininfo, "pwd", "")
		self.idEditLine.SetText(id)
		self.pwdEditLine.SetText(pwd)
		slot = getValue(logininfo, "slot", "0")
		locale = getValue(logininfo, "locale", "")
		locale_dir = getValue(logininfo, "locale_dir", "")
		is_auto_login = int(getValue(logininfo, "auto_login", "0"))

		self.stream.SetCharacterSlot(int(slot))
		self.stream.isAutoLogin=is_auto_login
		self.stream.isAutoSelect=is_auto_login

		if locale and locale_dir:
			app.ForceSetLocale(locale, locale_dir)

		if 0 != is_auto_login:
			self.Connect(id, pwd)

		return


	def PopupDisplayMessage(self, msg):
		self.stream.popupWindow.Close()
		self.stream.popupWindow.Open(msg)

	def PopupNotifyMessage(self, msg, func=0):
		if not func:
			func=self.EmptyFunc

		self.stream.popupWindow.Close()
		self.stream.popupWindow.Open(msg, func, localeInfo.UI_OK)


	def OnPressExitKey(self):
		self.stream.popupWindow.Close()
		self.stream.SetPhaseWindow(0)
		return True

	def OnExit(self):
		self.stream.popupWindow.Close()
		self.stream.popupWindow.Open(app.Exit, localeInfo.UI_OK)

	def OnUpdate(self):
		ServerStateChecker.Update()
		for i in range(1,7):
			if os.path.exists('lib/savedaccounts/' + (str(i))+ '.cfg'):
				accountfile = open('lib/savedaccounts/' + (str(i))+ '.cfg', "r")
				informations = (accountfile.read()).split("|")
				self.registerButtons[i].SetText(informations[1])
			else:
				self.registerButtons[i].SetText(uiScriptLocale.FREE)

	def EmptyFunc(self):
		pass


	def __GetRegionID(self):
		return 0

	def __GetServerID(self):
		return self.serverList.GetSelectedItem()


	def __ServerIDToServerIndex(self, regionID, targetServerID):
		try:
			regionDict = serverInfo.REGION_DICT[regionID]
		except KeyError:
			return -1

		retServerIndex = 0
		for eachServerID, regionDataDict in regionDict.items():
			if eachServerID == targetServerID:
				return retServerIndex

			retServerIndex += 1
		return -1

	def __ChannelIDToChannelIndex(self, channelID):
		return channelID - 1

	def __OpenServerBoard(self):
		loadRegionID, loadServerID, loadChannelID = self.__LoadChannelInfo()
		serverIndex = self.__ServerIDToServerIndex(loadRegionID, loadServerID)
		channelIndex = self.__ChannelIDToChannelIndex(loadChannelID)
		self.serverList.SelectItem(serverIndex)

		self.loginBoard.Hide()

	def __SelectChannel(self, channel):
		self.ChannelButtons = { 1 : [self.ChannelButton1, serverInfo.SRV1["ch1"]], 2 : [self.ChannelButton2, serverInfo.SRV1["ch2"]], 3 : [self.ChannelButton3, serverInfo.SRV1["ch3"]], 4 : [self.ChannelButton4, serverInfo.SRV1["ch4"]] }
		self.ChannelButton1.SetUp()
		self.ChannelButton2.SetUp()
		self.ChannelButton3.SetUp()
		self.ChannelButton4.SetUp()
		self.ChannelButtons[channel][0].Down()
		self.stream.SetConnectInfo(serverInfo.SRV1["host"], self.ChannelButtons[channel][1], serverInfo.SRV1["host"], serverInfo.SRV1["auth1"])
		net.SetMarkServer(serverInfo.SRV1["host"], serverInfo.SRV1["ch1"])
		app.SetGuildMarkPath("10.tga")
		app.SetGuildSymbolPath("10")

	def __SaveChannelInfo(self):
		try:
			file=open("channel.inf", "w")
			file.write("%d %d %d" % (self.__GetServerID(), self.__GetChannelID(), self.__GetRegionID()))
		except:
			print "LoginWindow.__SaveChannelInfo - SaveError"

	def __LoadChannelInfo(self):
		try:
			file=open("channel.inf")
			lines=file.readlines()

			if len(lines)>0:
				tokens=lines[0].split()
				selServerID=int(tokens[0])
				selChannelID=int(tokens[1])

				if len(tokens) == 3:
					regionID = int(tokens[2])

				return regionID, selServerID, selChannelID
		except:
			print "LoginWindow.__LoadChannelInfo - OpenError"
			return -1, -1, -1
	def __OpenLoginBoard(self):

		loadRegionID, loadServerID, loadChannelID = self.__LoadChannelInfo()
		serverIndex = self.__ServerIDToServerIndex(loadRegionID, loadServerID)
		channelIndex = self.__ChannelIDToChannelIndex(loadChannelID)
		self.__SelectChannel(1)
		self.serverList.SelectItem(serverIndex)

		if app.loggined:
			self.Connect(self.id, self.pwd)
			self.loginBoard.Hide()
		elif not self.stream.isAutoLogin:
			self.loginBoard.Show()

		if self.idEditLine == None:
			self.idEditLine.SetText("")

		if self.pwdEditLine == None:
			self.pwdEditLine.SetText("")

		self.idEditLine.SetFocus()

	def __OnSelectRegionGroup(self):
		self.__RefreshServerList()

	def __OnSelectSettlementArea(self):
		regionID = self.__GetRegionID()
		serverID = self.serverListOnRegionBoard.GetSelectedItem()
		serverIndex = self.__ServerIDToServerIndex(regionID, serverID)
		self.serverList.SelectItem(serverIndex)
		self.__OnSelectServer()

	def __RefreshServerList(self):
		regionID = self.__GetRegionID()
		if not serverInfo.REGION_DICT.has_key(regionID):
			return

		self.serverList.ClearItem()

		regionDict = serverInfo.REGION_DICT[regionID]
		visible_index = 1
		for id, regionDataDict in regionDict.items():
			name = regionDataDict.get("name", "noname")
			try:
				server_id = serverInfo.SERVER_ID_DICT[id]
			except:
				server_id = visible_index

			self.serverList.InsertItem(id, "  %02d. %s" % (int(server_id), name))
			visible_index += 1

	def __OnSelectServer(self):
		self.__RequestServerStateList()
		self.__RefreshServerStateList()

	def __RequestServerStateList(self):
		regionID = self.__GetRegionID()
		serverID = self.__GetServerID()

		try:
			channelDict = serverInfo.REGION_DICT[regionID][serverID]["channel"]
		except:
			print " __RequestServerStateList - serverInfo.REGION_DICT(%d, %d)" % (regionID, serverID)
			return

		ServerStateChecker.Initialize();
		for id, channelDataDict in channelDict.items():
			key=channelDataDict["key"]
			ip=channelDataDict["ip"]
			udp_port=channelDataDict["udp_port"]
			ServerStateChecker.AddChannel(key, ip, udp_port)

		ServerStateChecker.Request()

	def __RefreshServerStateList(self):
		regionID = self.__GetRegionID()
		serverID = self.__GetServerID()
		try:
			channelDict = serverInfo.REGION_DICT[regionID][serverID]["channel"]
		except:
			print " __RequestServerStateList - serverInfo.REGION_DICT(%d, %d)" % (regionID, serverID)
			return

		for channelID, channelDataDict in channelDict.items():#06.01.2020
			channelState = channelDataDict["state"]
			self.ChannelTooltips = { 1 : self.ChannelButtonTooltip1, 2 : self.ChannelButtonTooltip2, 3 : self.ChannelButtonTooltip3, 4 : self.ChannelButtonTooltip4 }
			if channelState == "NORM":
				self.ChannelTooltips[channelID].SetText("|cff32cd32%s" % channelState)
			elif channelState == "BUSY":
				self.ChannelTooltips[channelID].SetText("|cffdaa520%s" % channelState)
			elif channelState == "FULL":
				self.ChannelTooltips[channelID].SetText("|cffff0000%s" % channelState)
			else:
				self.ChannelTooltips[channelID].SetText("|cffff0000%s" % channelState)

	def __GetChannelName(self, regionID, selServerID, selChannelID):
		try:
			return serverInfo.REGION_DICT[regionID][selServerID]["channel"][selChannelID]["name"]
		except KeyError:
			if 9==selChannelID:
				return localeInfo.CHANNEL_PVP
			else:
				return localeInfo.CHANNEL_NORMAL % (selChannelID)

	def NotifyChannelState(self, addrKey, state):
		try:
			stateName=serverInfo.STATE_DICT[state]
		except:
			stateName=serverInfo.STATE_NONE

		regionID=int(addrKey/1000)
		serverID=int(addrKey/10) % 100
		channelID=addrKey%10

		try:
			serverInfo.REGION_DICT[regionID][serverID]["channel"][channelID]["state"] = stateName
			self.__RefreshServerStateList()
		except:
			import exception
			exception.Abort(localeInfo.CHANNEL_NOT_FIND_INFO)

	def __OnClickExitServerButton(self):
		print "exit server"
		self.__OpenLoginBoard()


	def __OnClickSelectRegionButton(self):
		regionID = self.__GetRegionID()
		serverID = self.__GetServerID()

		if (not serverInfo.REGION_DICT.has_key(regionID)):
			self.PopupNotifyMessage(localeInfo.CHANNEL_SELECT_REGION)
			return

		if (not serverInfo.REGION_DICT[regionID].has_key(serverID)):
			self.PopupNotifyMessage(localeInfo.CHANNEL_SELECT_SERVER)
			return

		self.__SaveChannelInfo()
		self.__RefreshServerList()
		self.__OpenLoginBoard()

	def OnClickRegisterButton(self, alper):#21.02.2019
		global RegisteredID
		global RegisteredPassword
		al = self.registerButtons[alper].GetText()
		if al.find(uiScriptLocale.FREE) != -1:
			id = self.idEditLine.GetText()
			pwd = self.pwdEditLine.GetText()
			if id == "" or pwd == "":
				self.PopupNotifyMessage(localeInfo.NOID_OR_PASSWORD)
			else:
				if not os.path.exists('lib/savedaccounts/' + str(alper) + '.cfg'):#todo security reg
					open('lib/savedaccounts/' + str(alper) + '.cfg', "w").write("|"+str(id)+"|"+str(pwd)+"|")

					self.registerButtons[alper].SetText(str(id))

					self.PopupNotifyMessage(localeInfo.ACCOUNT_HAS_REGISTERED)
				else:
					pass
		else:
			accountfile = open('lib/savedaccounts/' + str(alper)+ '.cfg', "r")
			informations = (accountfile.read()).split("|")
			self.Connect(informations[1], informations[2])
			RegisteredID = informations[1]
			RegisteredPassword = informations[2]


	def __OnClickdeleteButton(self, alper):
		al = self.registerButtons[alper].GetText()

		if al.find(uiScriptLocale.FREE) != -1:
			self.PopupNotifyMessage(localeInfo.NO_DELETE_ACCOUNT)
			return
		else:
			os.remove('lib/savedaccounts/' + str(alper)+ '.cfg')
			self.registerButtons[alper].SetText(uiScriptLocale.FREE)
			self.PopupNotifyMessage(localeInfo.ACCOUNT_HAS_DELETED)

	def __OnClickPasswordRestart(self):
		os.startfile("https://www.metin2.org")

	def __OnClickFacebook(self):
		os.startfile("https://facebook.com/metin2")

	def __OnClickinstagram(self):
		os.startfile("https://instagram.com/metin2")

	def __OnClickYoutube(self):
		os.startfile("https://facebook.com/metin2")

	def __OnClickDiscord(self):
		os.startfile("https://discord.com")

	def __OnClickChangeLanguage(self, language):#03.03.2019
		self.Languages = { "tr" : "1254 tr", "en" : "1252 en", "de" : "1252 de", "hu" : "1250 hu", "pt" : "1252 pt", "ro" : "1250 ro", "es" : "1252 es"}
		file = open("loca.cfg", "w")#GF Update loca.cfg
		file.write(self.Languages[str(language)])#tunga
		file.close()
		dbg.LogBox("The laguage of client was changed.")
		dbg.LogBox("Please start your game again.")
		net.ExitApplication()

	def OnKeyDown(self, key):#06.04.2019
#thanks vegas
		if 1 == key: #ESC
			self.OnPressExitKey()
		elif 59 == key: #F1
			self.OnClickRegisterButton(1)
		elif 60 == key: #F2
			self.OnClickRegisterButton(2)
		elif 61 == key: #F3
			self.OnClickRegisterButton(3)
		elif 62 == key: #F4
			self.OnClickRegisterButton(4)
		elif 63 == key: #F5
			self.OnClickRegisterButton(5)
		elif 64 == key: #F6
			self.OnClickRegisterButton(6)
		else:
			return True
		return True

	def __OnClickLoginButton(self):
		id = self.idEditLine.GetText()
		pwd = self.pwdEditLine.GetText()

		if len(id)==0:
			self.PopupNotifyMessage(localeInfo.LOGIN_INPUT_ID, self.SetIDEditLineFocus)
			return

		if len(pwd)==0:
			self.PopupNotifyMessage(localeInfo.LOGIN_INPUT_PASSWORD, self.SetPasswordEditLineFocus)
			return

		self.Connect(id, pwd)
#Tunga
