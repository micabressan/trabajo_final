-- Do not remove the green text!
-- ><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><

-- Script by: John_Scott
-- Skype: dekaman12
-- Release date: 2013.01.06
-- Made in Hungary
-- Original langue: Hungaryan

-- >>>>> Hard Bytes Team <<<<<
-- facebook.com/HardBytesTeam
-- IP: 91.82.85.203:22076
-- >>>>> Hard Bytes Team <<<<<
 
-- ><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
-- Do not remove the green text!




wdwLogin_Pannel = {}
tabPannel_Main = {}
tab_Login = {}
tab_Register = {}

function open_log_reg_pannel()
if not(isElement(wdwLogin_Pannel)) then
	 
	showChat(false)
	
	x,y = guiGetScreenSize()
	
	local sWidth,sHeight = guiGetScreenSize() 
	local Width,Height = 350,350
	local X = (sWidth/2) - (Width/2)
	local Y = (sHeight/2) - (Height/2)
	
	setCameraMatrix(-1677.4290771484,598.68981933594,164.63450622559,-1676.6274414063,599.05981445313,164.16494750977,0,70)
	Login_img = guiCreateStaticImage( X, Y + 120, 350, 350, "login_window.png", false )
	guiSetEnabled (Login_img, false)
	
	--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    shLogin = guiCreateStaticImage( X + 23, Y + 349, 301, 44, "login.png", false )
	addEventHandler("onClientGUIClick",shLogin,onClickBtnLogin)
	addEventHandler( "onClientMouseEnter",shLogin,LoginSH)
	addEventHandler("onClientMouseLeave",shLogin,SErem)
	
	edit_Login = guiCreateEdit(X + 20,Y + 205,250,35,"",false)
	edit_password = guiCreateEdit(X + 20,Y + 280,250,35,"",false)
	guiEditSetMaxLength ( edit_Login,25)
	guiEditSetMaxLength ( edit_password,25)
	guiEditSetMasked ( edit_password, true )
	
	lbl_about_legth = guiCreateLabel(142,42,184,18,"",false)
	guiLabelSetColor(lbl_about_legth,253,255,68)
	guiLabelSetVerticalAlign(lbl_about_legth,"center")
	guiLabelSetHorizontalAlign(lbl_about_legth,"center",false)
	
	checkbox_save = guiCreateCheckBox(X + 175,Y + 260,100,20,"(Remember me!)",false,false)
	guiSetFont(checkbox_save,"default-small")
	
	
	
	login_tab_error_msg = guiCreateLabel(X,Y + 310,364,31,"Error_login_tab",false)
	guiLabelSetColor(login_tab_error_msg,255,0,0)
	guiLabelSetVerticalAlign(login_tab_error_msg,"center")
	guiLabelSetHorizontalAlign(login_tab_error_msg,"center",false)
	guiSetFont(login_tab_error_msg,"default-bold-small")

		
	--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	shGuest = guiCreateStaticImage( X + 23, Y + 401, 143, 45, "guest.png", false ) -- A gomb
	addEventHandler("onClientGUIClick",shGuest,onClickGuest)
	addEventHandler( "onClientMouseEnter",shGuest,GuestSH)
	addEventHandler("onClientMouseLeave",shGuest,SErem)
	
	lbl_reg_top_info = guiCreateLabel(X - 70,Y + 380,500,30,"Fill out all fields. Do no't use: (\"!@#$\"%'^&*()\")",false)
	guiLabelSetColor(lbl_reg_top_info,255,234,55)
	guiLabelSetVerticalAlign(lbl_reg_top_info,"center")
	guiLabelSetHorizontalAlign(lbl_reg_top_info,"center",false)
	guiSetVisible(lbl_reg_top_info,false)
	
	edit_account_name = guiCreateEdit(X + 20,Y + 210,250,35,"",false)
	guiEditSetMaxLength ( edit_account_name,25)
	guiSetVisible(edit_account_name,false)
	
	edit__reg_tab_password = guiCreateEdit(X + 20,Y + 275,250,35,"",false)
	guiEditSetMaxLength ( edit__reg_tab_password,25)
	guiEditSetMasked ( edit__reg_tab_password, true )
	guiSetVisible(edit__reg_tab_password,false)
	
	
	edit__reg_tab_Repassword = guiCreateEdit(X + 20,Y + 345,250,35,"",false)
	guiEditSetMaxLength ( edit__reg_tab_Repassword,25)
	guiEditSetMasked ( edit__reg_tab_Repassword, true )
	guiSetVisible(edit__reg_tab_Repassword,false)
	guiSetEnabled (edit__reg_tab_Repassword, true)	
	
	--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	shRegister = guiCreateStaticImage( X + 182, Y + 401, 143, 45, "register.png", false )
	addEventHandler("onClientGUIClick",shRegister,OnBtnRegister)
	addEventHandler( "onClientMouseEnter",shRegister,RegisterSH)
	addEventHandler("onClientMouseLeave",shRegister,SErem)
	
	--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	shRegister2 = guiCreateStaticImage( X + 23, Y + 409, 301, 44, "register2.png", false )
	addEventHandler("onClientGUIClick",shRegister2,onClickBtnRegister)
	addEventHandler( "onClientMouseEnter",shRegister2,Register2SH)
	addEventHandler("onClientMouseLeave",shRegister2,SErem)
    
	guiSetVisible(shRegister2,false)
	
	reg_tab_error_msg = guiCreateLabel(X,Y + 310,364,31,"Error_reg_ttab",false)
	guiLabelSetColor(reg_tab_error_msg,255,20,0)
	guiLabelSetVerticalAlign(reg_tab_error_msg,"center")
	guiLabelSetHorizontalAlign(reg_tab_error_msg,"center",false)
	guiSetFont(reg_tab_error_msg,"default-bold-small")
	

	showCursor(true)

	guiSetText(reg_tab_error_msg, "")
	guiSetText(login_tab_error_msg, "")
	
	
	local username, password = loadLoginFromXML()
	
	if not( username == "" or password == "") then
		guiCheckBoxSetSelected ( checkbox_save, true )
		guiSetText ( edit_Login, tostring(username))
		guiSetText ( edit_password, tostring(password))
	else
		guiCheckBoxSetSelected ( checkbox_save, false )
		guiSetText ( edit_Login, tostring(username))
		guiSetText ( edit_password, tostring(password))
	end
	end
	
end

function LoginSH ()
	guiStaticImageLoadImage(shLogin, "sh.png" )
end

function RegisterSH ()
	guiStaticImageLoadImage(shRegister, "shr.png" )
end

function Register2SH ()
	guiStaticImageLoadImage(shRegister2, "shr2.png" )
end

function GuestSH ()
	guiStaticImageLoadImage(shGuest, "shg.png" )
end

function SErem ()
guiStaticImageLoadImage(shLogin, "login.png" )
guiStaticImageLoadImage(shRegister, "register.png" )
guiStaticImageLoadImage(shGuest, "guest.png" )
guiStaticImageLoadImage(shRegister2, "register2.png" )
end

function start_cl_resource()
	open_log_reg_pannel()
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),start_cl_resource)


function loadLoginFromXML()
	local xml_save_log_File = xmlLoadFile ("files/xml/userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("files/xml/userdata.xml", "login")
    end
    local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
    local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
    if usernameNode and passwordNode then
        return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
    else
		return "", ""
    end
    xmlUnloadFile ( xml_save_log_File )
end
 
 
function saveLoginToXML(username, password)
    local xml_save_log_File = xmlLoadFile ("files/xml/userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("files/xml/userdata.xml", "login")
    end
	if (username ~= "") then
		local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "username")
		end
		xmlNodeSetValue (usernameNode, tostring(username))
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end		
		xmlNodeSetValue (passwordNode, tostring(password))
	end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile (xml_save_log_File)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)



function resetSaveXML()
		local xml_save_log_File = xmlLoadFile ("files/xml/userdata.xml")
		if not xml_save_log_File then
			xml_save_log_File = xmlCreateFile("files/xml/userdata.xml", "login")
		end
		if (username ~= "") then
			local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
			if not usernameNode then
				usernameNode = xmlCreateChild(xml_save_log_File, "username")
			end
		end
		if (password ~= "") then
			local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
			if not passwordNode then
				passwordNode = xmlCreateChild(xml_save_log_File, "password")
			end		
			xmlNodeSetValue (passwordNode, "")
		end
		xmlSaveFile(xml_save_log_File)
		xmlUnloadFile (xml_save_log_File)
end
addEvent("resetSaveXML", true)
addEventHandler("resetSaveXML", getRootElement(), resetSaveXML)

function onClickBtnLogin(button,state)
	
	showChat(true)
	showCursor(false)
	guiSetVisible(Image,false)
		guiSetVisible(shGuest, false)
		guiSetVisible(Image, false)
		guiSetVisible(shLogin, false)
		guiSetVisible(shRegister, false)
		guiSetVisible(edit_password, false)
		guiSetVisible(edit_Login, false)
		guiSetVisible(checkbox_save, false)
		guiSetVisible(Login_img, false)
	
	
	if(button == "left" and state == "up") then
		if (source == shLogin) then
			username = guiGetText(edit_Login)
			password = guiGetText(edit_password)
				if guiCheckBoxGetSelected ( checkbox_save ) == true then
					checksave = true
				else
					checksave = false
				end
			triggerServerEvent("onRequestLogin",getLocalPlayer(),username,password,checksave)
		end
	end
end

function OnBtnRegister ()
	guiStaticImageLoadImage(Login_img, "register_window.png" )
	guiSetVisible(shRegister2, true)
	guiSetVisible(lbl_reg_top_info,true)
	guiSetVisible(edit__reg_tab_Repassword,true)
	guiSetEnabled (edit__reg_tab_Repassword, true)
	guiSetVisible(edit__reg_tab_password,true)
	guiSetVisible(edit_account_name,true)
	   guiSetVisible(shGuest, false)
		guiSetVisible(shLogin, false)
		guiSetVisible(shRegister, false)
		guiSetVisible(edit_password, false)
		guiSetVisible(edit_Login, false)
		guiSetVisible(checkbox_save, false)
end

function onClickBtnRegister(button,state)
	
	
	guiStaticImageLoadImage(Login_img, "Login_window.png" )
	 
		guiSetVisible(shGuest, true)
	    guiSetVisible(shLogin, true)
		guiSetVisible(shRegister, true)
		guiSetVisible(edit_password, true)
		guiSetVisible(edit_Login, true)
		guiSetVisible(checkbox_save, true)
		guiSetVisible(shRegister2, false)
		guiSetVisible(edit__reg_tab_password, false)
		guiSetVisible(edit__reg_tab_Repassword, false)
		guiSetVisible(edit_account_name, false)
		guiSetVisible(lbl_reg_top_info, false)
	    showCursor(true)
	
	--
			username = guiGetText(edit_account_name)
			password = guiGetText(edit__reg_tab_password)
			passwordConfirm = guiGetText(edit__reg_tab_Repassword)
			triggerServerEvent("onRequestRegister",getLocalPlayer(),username,password,passwordConfirm)
			
			guiSetText(reg_tab_error_msg, "Successful register! Now log in!")
			guiLabelSetColor ( reg_tab_error_msg, 0, 255, 0 )
		    setTimer(function() guiSetText(reg_tab_error_msg, "") end,3000,1)
			setTimer(function() guiLabelSetColor ( reg_tab_error_msg, 255, 0, 0 ) end,3000,1)
			
end



function Error_msg(Tab, Text)
showCursor(true)
	if Tab == "Login" then 
	
	    guiSetVisible(btnGuest, true)
		guiSetVisible(shGuest, true)
		guiSetVisible(Image, true)
		guiSetVisible(shLogin, true)
		guiSetVisible(shRegister, true)
		guiSetVisible(btn_reg_tab_register, true)
		guiSetVisible(edit_password, true)
		guiSetVisible(edit_Login, true)
		guiSetVisible(checkbox_save, true)
		guiSetVisible(Login_img, true)

	
		guiSetText(login_tab_error_msg, tostring(Text))
		setTimer(function() guiSetText(login_tab_error_msg, "") end,3000,1)
	elseif Tab == "Register" then
		guiSetText(reg_tab_error_msg, tostring(Text))
		setTimer(function() guiSetText(reg_tab_error_msg, "") end,3000,1)
	end
end
addEvent("set_warning_text",true)
addEventHandler("set_warning_text",getRootElement(),Error_msg)


function onClickGuest()
	
	showChat(true)
	
	guiSetVisible(Image,false)
		guiSetVisible(shGuest, false)
		guiSetVisible(Image, false)
		guiSetVisible(shLogin, false)
		guiSetVisible(shRegister, false)
		guiSetVisible(edit_password, false)
		guiSetVisible(edit_Login, false)
		guiSetVisible(checkbox_save, false)
		guiSetVisible(Login_img, false)
			showCursor(false)
end


function hideLoginWindow()
	
	outputChatBox("Welcome! Thanks for use -HBT- Login Panel | By.: John_Scott | © HBT - 2013")
    setCameraTarget (localPlayer)
	showCursor(false)
	showChat(true)
	removeEventHandler("onClientGUIClick",shLogin,onClickBtnLogin)
end
addEvent("hideLoginWindow", true)
addEventHandler("hideLoginWindow", getRootElement(), hideLoginWindow)

function CursorError ()
outputChatBox("Kurzor elrejtve")
showCursor(false)
end
addCommandHandler("showc", CursorError)