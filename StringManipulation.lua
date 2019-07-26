local TweenService = game:GetService("TweenService")
math.randomseed(os.time()^5)

local alphabet = {" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", 
					"k", "l", "m", "n", "o", "p", "q", "r", "s", "t", 
						"u", "v", "w", "x", "y", "z", "A", "B", "C", "D", 
							"E", "F", "G", "H", "I", "J", "K", "L", "M", "N", 
								"O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", 
									"Y", "Z", "!", "?", "#", "$", "%", "&", "+", "-", 
										"'", '"', ",", ".", ";", ":", "(", ")", "1", "2",
											"3", "4", "5", "6", "7", "8", "9", "0"}

local sm = {}

	function sm.GetAlphabetPosition(l)
		for position,letter in ipairs(alphabet) do
			if letter == l then
				return position
			end
		end
		return 1
	end
	-- 0 speed = typewriter effect, higher speed = rolling text effect
	-- returns true when it's complete, use if statement if you want to fire events when it finished typing
	function sm.RollingTextLabel(obj, str, speed)
		local length = str:len()
		local seperatedString = {}
		local tempString = {}
		str:gsub(".",function(c) table.insert(seperatedString,c) end)
		for i = 1, #seperatedString do
			local position = sm.GetAlphabetPosition(seperatedString[i])
			for a = position-speed, position do
				seperatedString[i] = alphabet[a]	
				tempString[i] = alphabet[a]			
				local newString = table.concat(tempString, "")
				obj.Text = newString
				wait()
			end
		end
		--set the text to the proper string, incase client lag or sumat screwed with it.
		local finalString = table.concat(seperatedString, "")
		return true
	end
	
	function sm.getday_posfix(day)
		local idd = day
		return (idd==1 and day~=11 and "st")  or (idd==2 and day~=12 and "nd") or (idd==3 and day~=13 and "rd") or "th"
	end
	function sm.getmonth(monthInt)
		local months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
		return months[tonumber(monthInt)]
	end
	
	--pass seconds as an int, will return in the format of 00 days 00:00:00
	function sm.MinutesToDaysHoursMinutes(minutes)
		local minutes = minutes ~= nil and tonumber(minutes) or 0
		if minutes <= 0 then
			return "0 minutes"
		else
			local daysInt = math.floor(minutes/1440);
			local daysString = ""
			if(daysInt > 0) then
				daysString = daysInt.." days, "
			end
			local hoursInt = math.floor(minutes/60 - (daysInt*24));
			local hoursString = ""
			if(hoursInt > 0) then
				hoursString = hoursInt.." hours, "
			end
			local minsInt = math.floor((minutes) - (hoursInt*60) - (daysInt*1440))
			local minsString = ""
			if(minsInt > 0) then
				minsString = minsInt.." minutes."
			end
			local endString = daysString..hoursString..minsString
			return endString
		end
	end
	--returns the date as a string in the form of "March 18th, 2018"
	function sm.DateIntsToString(dayInt, monthInt, yearInt)
		local ordinalDayString = tostring(dayInt)..sm.getday_posfix(dayInt)
		local monthString = sm.getmonth(monthInt)
		local endString = ordinalDayString.." of "..monthString..", "..tostring(yearInt)
		return endString
	end
	
	function sm.DayToDate(day)
		local date
		
		
		return date
	end
	
	sm.SizeFromCategory = {}
	sm.SizeFromCategory["Phone"] = 6
	sm.SizeFromCategory["Tablet"] = 10
	sm.SizeFromCategory["Average"] = 13
	
	local function GetScreenCategory(screen_size)
		local category = "Average"
		category = (screen_size.X <= 900 and screen_size.Y <= 450) and "Phone" or (screen_size.X > 900 and screen_size.X <=1100 and screen_size.Y > 450 and screen_size.Y <= 900) and "Tablet" or (screen_size.X > 1100 and screen_size.X <= 2000 and screen_size.Y >900 and screen_size.Y <= 1200) and "Average" or "Average"
		return category
	end
		
	function sm.GetMaxTextSize(screen_size)
		local size = 10
		if screen_size then
			local screen_category = GetScreenCategory(screen_size)
			size = sm.SizeFromCategory[screen_category] or 10
		end
		return size
	end
	
	local charset = {}  do -- [0-9a-zA-Z]
	    for c = 48, 57  do table.insert(charset, string.char(c)) end
	    for c = 65, 90  do table.insert(charset, string.char(c)) end
	    for c = 97, 122 do table.insert(charset, string.char(c)) end
	end

	function sm.RandomString(length)
	   if not length or length <= 0 then return '' end
 	   return sm.RandomString(length - 1) .. charset[math.random(1, #charset)]
	end
	
	function sm.HourFromString(s)
		if s and typeof(s) == "string" then
			return tonumber(string.match(s, "%d+"))
		end
		return nil
	end
	
	function sm.SecondsToHours(s)
		return s / 3600
	end
	
	--Removes commas
	function sm.remove_commas(v)
		return string.gsub(v, ",", "")
	end
	
	-- int = 100,000
	-- string would be 100k
	function sm.IntToString(int)
		
	end
	
	function sm.FirstCharToUpper(str)
		return (str:gsub("^%l", string.upper))
	end
	
	--Pass a string of an enum, returns the actual enum. (pass "Enum.KeyCode.ButtonA", get Enum.KeyCode.ButtonA)
	function sm.EnumFromString(s)
		local enum = nil
		if s and #s >0 then
			local EnumType = string.gsub(string.match(s, "%.%w+%."), "%.","")
			local EnumValue = EnumType and string.gsub(string.match(s, EnumType.."%.%w+"), EnumType, "")
			EnumValue = EnumValue and string.gsub(EnumValue, "%.", "")
			local is_enum, e = pcall(function()
				if Enum[EnumType] and Enum[EnumType][EnumValue] then
					enum = Enum[EnumType][EnumValue]
				end
			end)
		end
		return enum
	end
	
	function sm.EnumFromEnumValue(EnumType, EnumValues)
		local enum = nil
			for _,v in pairs(EnumValues) do
				enum = sm.EnumFromString("Enum."..v.."."..EnumType)
				if enum then
					return enum
				end
			end
		return enum
	end
	
	---------------------------------
	--CONVERT COMMA STRING TO TABLE--
	---------------------------------
	
	--[[This will use gmatch to turn a "comma string" to a into a table and return it]]--
	--[[
		Both arguments are strings.
		The first arugment is the string you want to turn into a table
		The second argument is the seperator which in default case is a comma, but you could make it ", " or ":" or anything else.

		Example:
		str = Pickaxe,Hatchet,Food,Bucket,
		seperator = , or nil --nill would default to a comma without a space.
	]]--
	function sm.ConvertCommaStringToTable(str, seperator)
		local t = {}
		if not seperator then seperator = "," end
		
		for i, v in string.gmatch(str, "([^"..seperator.."]+)") do
			t[i] = ""
		end
		
		return t
	end
return sm
