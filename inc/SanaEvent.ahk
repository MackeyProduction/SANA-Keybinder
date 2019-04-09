class SanaEvent
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
		
		return newsArray
	}
	
	; getter and setter for event name
	SetEventName(value)
	{
		return this.eventName := value
	}
	
	GetEventName()
	{
		return this.eventName
	}
	
	; getter and setter for event rounds
	SetEventRounds(value)
	{
		return this.eventRounds := value
	}
	
	GetEventRounds()
	{
		return (this.eventRounds != 0) ? this.eventRounds : 5
	}
	
	; getter and setter for question name
	SetQuestionName(value)
	{
		return this.eventQuestionName := value
	}
	
	GetQuestionName()
	{
		return this.eventQuestionName
	}
	
	; getter and setter for answer name
	SetAnswerName(value)
	{
		return this.eventAnswerName := value
	}
	
	GetAnswerName()
	{
		return this.eventAnswerName
	}
}