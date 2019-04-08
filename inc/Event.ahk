﻿class Event
{
	__New()
	{
		static init
		
		if init
			return init
		
		init := this
	}
	
	GetEventNewsText(eventArray)
	{
		newsArray := ["SAN:NEWS - Wortsalat", format("{0} Runden", eventArray["Runden"]), format("Für jede richtige Lösung gibt es eine Gewinnsumme von {0}!", 50000), format("Schick mir die richtige Antwort per SMS an die ID {0}!", GetPlayerId())]
	}
	
	SetEventName(value)
	{
		return this.eventName := value
	}
	
	GetEventName()
	{
		return this.eventName
	}
	
	SetEventRounds(value)
	{
		return this.eventRounds := value
	}
	
	GetEventRounds()
	{
		return (this.eventRounds != 0) ? this.eventRounds : 5
	}
	
	SetQuestionName(value)
	{
		return this.eventQuestionName := value
	}
	
	GetQuestionName()
	{
		return this.eventQuestionName
	}
	
	SetAnswerName(value)
	{
		return this.eventAnswerName := value
	}
	
	GetAnswerName()
	{
		return this.eventAnswerName
	}
	
	EventName[] {
		get {
			return this.eventName
		}
		set {
			return this.eventName := value
		}
	}
	
	EventRounds[] {
		get {
			return (this.eventRounds != 0) ? this.eventRounds : 5
		}
		set {
			return this.eventRounds := value
		}
	}
}