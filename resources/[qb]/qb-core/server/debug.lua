local function tPrint(tbl, indent)
    indent = indent or 0
    for k, v in pairs(tbl) do
        local tblType = type(v)
        local formatting = ("%s ^3%s:^0"):format(string.rep("  ", indent), k)

        if tblType == "table" then
            print(formatting)
            tPrint(v, indent + 1)
        elseif tblType == 'boolean' then
            print(("%s^1 %s ^0"):format(formatting, v))
        elseif tblType == "function" then
            print(("%s^9 %s ^0"):format(formatting, v))
        elseif tblType == 'number' then
            print(("%s^5 %s ^0"):format(formatting, v))
        elseif tblType == 'string' then
            print(("%s ^2'%s' ^0"):format(formatting, v))
        else
            print(("%s^2 %s ^0"):format(formatting, v))
        end
    end
end

RegisterServerEvent('QBCore:DebugSomething', function(table, indent)
    local resource = GetInvokingResource() or "qb-core"

    print(('\x1b[4m\x1b[36m[ %s : DEBUG]\x1b[0m'):format(resource))

    tPrint(table, indent)

    print('\x1b[4m\x1b[36m[ END DEBUG ]\x1b[0m')
end)

function QBCore.Debug(table, indent)
    TriggerEvent('QBCore:DebugSomething', table, indent)
end

function QBCore.ShowError(resource, msg)
    exports['soz-core']:Log('ERROR', msg, { resource = resource })
end

function QBCore.ShowSuccess(resource, msg)
    exports['soz-core']:Log('INFO', msg, { resource = resource })
end
