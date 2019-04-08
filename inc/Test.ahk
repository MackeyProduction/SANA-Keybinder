!x::
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