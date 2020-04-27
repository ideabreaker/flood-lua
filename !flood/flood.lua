local level = 0

function floodSA(source,command,speed)
	if (isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(source)),aclGetGroup("Admin"))) then
		if (speed) then
			if (isTimer(waterTimer)) then
				killTimer(waterTimer)
				destroyElement(floodWater)
				setWaterLevel(0)
				level = 0
				outputDebugString ("Powódź została wyłączona przez server.")
			end
			local speed = tonumber(speed)
			floodWater = createWater(-2998,-2998,0,2998,-2998,0,-2998,2998,0,2998,2998,0)
			outputChatBox("--------------------------------",getRootElement(),255,0,0)
			outputChatBox("UWAGA: STAN ALARMOWY! POZIOM WODY SIE PODNOSI!",getRootElement(),255,0,0)
			outputChatBox("--------------------------------",getRootElement(),255,0,0)
			waterTimer = setTimer(addSomeWater,100,0,speed)
			outputDebugString("Powódź została włączona przez "..getPlayerName (source).." z prędkością "..speed..".")
		else
			outputChatBox("Określ prędkość.",source,255,0,0)
		end
	else
		outputChatBox ("Nie posiadasz uprawnień do tej komendy!",source,255,0,0)
	end
end
addCommandHandler("flood",floodSA)

function addSomeWater(speed)
    level = level+speed/100
    setWaterLevel(level)
end

function stopFlood(source,command)
	if (isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)),aclGetGroup("Admin"))) then
			if (isTimer(waterTimer)) then
				killTimer(waterTimer)
				destroyElement(floodWater)
				setWaterLevel(0)
				level = 0
				outputDebugString("Flooding stopped by "..getPlayerName(source)..".")
				outputChatBox("Poziom wody opadł. Sytuacja jest pod kontrolą, możecie wracać!",getRootElement(),255,0,0)
			else
				outputChatBox("Nie masz co zastopować.",source,255,0,0)
			end
	else
		outputChatBox ("Nie posiadasz permisji do tej komendy!",source,255,0,0)
	end
end
addCommandHandler("flood-stop",stopFlood)

function resetWater()
	setWaterLevel(0)
end
addEventHandler("onResourceStop",getResourceRootElement(getThisResource()),resetWater)
