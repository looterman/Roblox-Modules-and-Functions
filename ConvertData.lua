-------------------
--SERIALIZES DATA--
local function ConvertDataToTable(resultTable, parent)
    local items = parent:GetChildren()    
    for i = 1, #items do
		resultTable[items[i].Name] = {}
        if (items[i]:IsA("Folder")) then
			resultTable[items[i].Name] = ConvertDataToTable(resultTable[items[i].Name], items[i])
		elseif (items[i]:IsA("Vector3Value")) then
			resultTable[items[i].Name] = {["X"] = items[i].X, ["Y"] = items[i].Y, ["Z"] = items[i].Z}
		else
			
			resultTable[items[i].Name] = items[i].Value
        end
    end
    return resultTable
end

---------------------
--DESERIALIZES DATA--
local function ConvertTableToData(parentTable, parentFolder)
    for key, value in pairs(parentTable) do
        if(typeof(value) == 'table') then
            local folder = Instance.new('Folder')
            folder.Name = key
            folder.Parent = parentFolder
            ConvertTableToData(value, folder)
        else
			local type = sm.FirstCharToUpper(typeof(value).."Value")
			if type == "BooleanValue" then type = "BoolValue" end
            local objectValue = Instance.new(type)
            objectValue.Name = key
            objectValue.Value = value
            objectValue.Parent = parentFolder
        end
    end
end