local ValueManipulation = {}

--Converts Value objects into a table.
function ValueManipulation.ValuesToTable(resultTable, parent)
    local items = parent:GetChildren()    
    for i = 1, #items do
		resultTable[items[i].Name] = {}
        if (items[i]:IsA("Folder")) then
			resultTable[items[i].Name] = ValueManipulation.ValuesToTable(resultTable[items[i].Name], items[i])
		elseif (items[i]:IsA("Vector3Value")) then
			resultTable[items[i].Name] = {["X"] = items[i].X, ["Y"] = items[i].Y, ["Z"] = items[i].Z}
		else
			
			resultTable[items[i].Name] = items[i].Value
        end
    end
    return resultTable
end

--Converts tables into value objects.
function ValueManipulation.TableToValues(parentTable, parentFolder)
    for key, value in pairs(parentTable) do
        if(typeof(value) == 'table') then
            local folder = Instance.new('Folder')
            folder.Name = key
            folder.Parent = parentFolder
            ValueManipulation.TableToData(value, folder)
        else
			local type = (typeof(value):gsub("^%1", string.upper)).."Value"
			if type == "BooleanValue" then type = "BoolValue" end
            local objectValue = Instance.new(type)
            objectValue.Name = key
            objectValue.Value = value
            objectValue.Parent = parentFolder
        end
    end
end

return ValueManipulation