﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#IfWinActive, GTA:SA:MP
#UseHook
#Include inc\API.ahk
#Include inc\Config.ahk
#Include inc\Event.ahk

; Initialisierung
scriptActivated = true
meMessagesActivated = true
dialogResponse = true
automateVehicle = true
minigameRounds = 5

!a::
	TestSaveEvents()
Return

TestSaveEvents()
{
	eventArray := []
	eventArray["eventName"] := "Quiz-Runde"
	eventArray["Frage"] := "foo;a;b;c;d"
	eventArray["Antwort"] := "bar;c;d;e;f"
	eventArray["Runden"] := "5"
	Config.SaveTempEvent("eventName", eventArray["eventName"])
	Config.SaveTempEvent("Frage", eventArray["Frage"])
	Config.SaveTempEvent("Antwort", eventArray["Antwort"])
	Config.SaveTempEvent("Runden", eventArray["Runden"])
	
	result := Config.ParseTempEvents(4)
	
	Config.SaveEvents(result)
}

/*
t::
Suspend On
SendInput t
Hotkey, Enter, On
Hotkey, Escape, On
Hotkey, t, Off
return

NumpadEnter::
Enter::
Suspend Permit
Suspend Off
SendInput {Enter}
Hotkey, t, On
Hotkey, Enter, Off
Hotkey, Escape, Off
return

Escape::
Suspend Permit
Suspend Off
SendInput {Escape}
Hotkey, t, On
Hotkey, Enter, Off
Hotkey, Escape, Off
return 
*/

; Prints InGame key help as chatlog
:?:/keyhelp::
	SendMultipleLines(Array("Alt+e - Liste mit Events.", "/frc - Alle Fahrzeuge werden respawnt.", "/nadn - Werbung für SANA, um neue Mitglieder zu bekommen.", "F12 - Keybinder aktivieren/deaktivieren."), true)
return

; Keybinds
!1::
!2::
!3::
!4::
!5::
!6::
!7::
!8::
!9::
!0::
	AddChatMessage("Funktion wurde noch nicht implementiert.")
return

#If IsDialogOpen()
~Enter::
	OnDialogResponse(true)
return

#If IsDialogOpen()
~LButton::
~Escape::
	if (IsDialogButton1Selected() && GetKeyState("LButton"))
		OnDialogResponse(true)
	
	OnDialogResponse(false)
return

SetEventName(eventName)
{
	ev = new Event()
	this.ev.EventName := eventName
	return this.ev.EventName
}

GetEventName()
{
	return this.ev.EventName
}

OnDialogResponse(response)
{
	if (response)
	{
		For key, val in GetDialogLines__()
		{
			index := GetDialogIndex()
			eventTempSavePath := Config.TempSavePath
			
			Case := GetDialogId() + index
			
			GoTo % IsLabel("Case-" Case) ? "Case-" Case : "Case-Default"
				
			Case-1001:
				OpenDialog(2, "Wortsalat`nQuiz-Runde`nWie heißt die Frage?!`nWerbe-Slogan raten`nFinde den Fehler`nErrate die Zahl", 2000)
			return
						
			Case-1002:
				OpenDialog(2, "Fly or Die`nFlaschenpost`nFinde den Van`nParkour`nRenn-Event`nCapture the vehicle`nTriathlon", 3000)
			return
						
			Case-2001:
			Case-2002:
			Case-2003:
			Case-2004:
			Case-2005:
			Case-2006:
				Config.SaveTempEvent("eventName", GetDialogLines__()[index])
				OpenDialog(2, "Fragen erstellen`nAntworten erstellen`nRunden festlegen", 2100)
			return
			
			Case-2101:
			Case-2102:
				eventArray := []
				
				eventTempSavePath := Config.TempSavePath
				dialogMessage := ["Frage", "Antwort"]
				questionAnswerType := dialogMessage[index]
				roundsHaystack := "Runden"
				maxRounds := 5
				counter := 0
				
				; check rounds of minigame
				Loop
				{
					FileReadLine, line, %eventTempSavePath%, %A_Index%
					
					if ErrorLevel
						break
					
					IfInString, line, %roundsHaystack%
					{
						lineSplit := StrSplit(line, "=")
						maxRounds := lineSplit[2]
					}
				}
				
				; Show dialogs
				while (counter < maxRounds)
				{
					OpenDialog(1, "Bitte gib deine " counter+1 ". " dialogMessage[index] " ein:", 2101)
					Input, inputDialog, V, {enter}
					
					; check if input string is empty
					while (inputDialog == "") {
						AddChatMessage("{F13B0E}Bitte einen gültigen Text eingeben!")
						OpenDialog(1, "Bitte gib deine " counter+1 ". " dialogMessage[index] " ein:", 2101)
						Input, inputDialog, V, {enter}
					}
					eventArray[questionAnswerType] .= inputDialog . ";"
					
					counter++
				}
				
				; save in temp file
				Config.SaveTempEvent(questionAnswerType, eventArray[questionAnswerType])
				
				; parse temp file in readable array
				result := Config.ParseTempEvents(4)
				
				; save data in events.ini
				Config.SaveEvents(result)
				AddChatMessage("{C1F10E}Alle Eingaben wurden erfolgreich gespeichert!")
				break
			return
			
			Case-2103:
				OpenDialog(1, "Wie viele Runden sollen gespielt werden?", 2103)
				Input, rounds, V, {enter}
				
				if (CheckRounds(rounds))
				{
					Config.SaveTempEvent("Runden", rounds)
					AddChatMessage("{C1F10E}Die Rundenanzahl wurde erfolgreich gespeichert!")
				}
			return
			
			Case-3001:
			Case-3002:
			Case-3003:
			Case-3004:
			Case-3005:
			Case-3006:
			Case-3007:
				Event.EventName := GetDialogLines__()[index]
				OpenDialog(2, "Runden festlegen", 3100)
			return
			
			Case-3101:
				goto Case-2103
			return
					
			Case-Default:
				return
		}
	}
}

; Events
#If !IsDialogOpen()
!e::
	OpenDialog(2, "Mini-Event`nSANA-Event", 1000)
return

CheckRounds(rounds)
{
	if (rounds <= 0) {
		AddChatMessage("{F13B0E}Es muss mindestens eine Runde festgelegt werden!")
		return false
	}
	
	if (rounds > 10) {
		AddChatMessage("{F13B0E}Es dürfen nicht mehr als zehn Runden festgelegt werden!")
		return false
	}
	
	return true
}

; Respawn cars
:?:/frc::
	counter := 20
	SendChat("/fc >> Carrespawn in 20 Sekunden! Alle bitte in Ihre Fahrzeuge begeben. <<")
	while (counter > 0)
	{
		if (counter == 10) 
		{
			SendChat("/fc >> Noch 10 Sekunden bis zum Fahrzeug-Respawn! <<")
		} else if (counter < 6)
		{
			SendChat("/fc >> " counter " <<")
		}
		counter--
		Sleep, 1000
	}
	SendChat("/respawncars")
	SendChat("/fc >> Respawn der Fahrzeuge wurde erfolgreich durchgeführt. <<")
return

; Ad for new sana members
:?:/nadn::
	SendNewsMessage(Array("SA:NA Bewerbungsrunde [OPEN]", "Die San Andreas News Agency sucht motivierte Reporter!", "Du wolltest schon immer Berichte schreiben und kleinere Events leiten?", "Dann bewirb dich noch heute bei der SA:NA!"))
return

; Automatic vehicle engine and light start
#If !IsInChat() && IsPlayerDriver() != -1 && automateVehicle
~F::
	if (GetVehicleEngineState())
		SendChat("/motor")
	
	if (GetVehicleLightState())
		SendChat("/licht")
return

#If !IsInChat() && !IsPlayerInAnyVehicle() && automateVehicle
~F::
	Loop, 50
	{
		if (IsPlayerDriver() != -1) 
		{
			if (!GetVehicleEngineState())
				SendChat("/motor")
			if (!GetVehicleLightState())
				SendChat("/licht")
			if (!GetVehicleLockState())
				SendChat("/flock")
			break
		}
		Sleep, 200
	}
return 

; Send news message in news notation
SendNewsMessage(newsMessage)
{
	if (!newsMessage.Equals("") && newsMessage.Count() > 0)
	{
		newsArray := []
		
		; convert to news array
		for key, val in newsMessage
			newsArray[key] := "/news .:: " val " ::."
		
		SendMultipleLines(newsArray)
	}
	else
		SendChat("/news .:: " newsMessage " ::.")
}

; Send multiple lines
SendMultipleLines(messageArray, isChatMessage = false)
{
	; check if param is an array
	if (!messageArray.Equals("") && messageArray.Count() > 0)
	{
		for key, val in messageArray
		{
			if (isChatMessage)
				AddChatMessage("{FFFFFF}"val)
			else
				SendChat(val)
			
			Sleep, 200
		}
	}
	
	return
}

OpenDialog(dialogType, content, dialogId)
{
	Sleep, 400
	ShowDialog(dialogType, "Event-Verwaltungstool", content, "Auswählen", "Abbrechen", dialogId)
}

; Toggle script
F12::
	Suspend, Permit
	
	scriptActivated := !scriptActivated
	if (meMessagesActivated)
	{
		if (scriptActivated)
			SendChat("/me hat seinen Keybinder aktiviert.")
		else 
			SendChat("/me hat seinen Keybinder deaktiviert.")
	}
	
	Suspend, Toggle
return