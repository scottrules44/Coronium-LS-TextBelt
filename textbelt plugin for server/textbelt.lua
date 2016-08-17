-- copyright Scott Harrison(scottrules44) Aug 11 2016
local http = require("socket.http")
local ltn12 = require("ltn12")
local m = {}
local json = require("cjson")

local function urlencode(str)
   if (str) then
      str = string.gsub (str, "\n", "\r\n")
      str = string.gsub (str, "([^%w ])",
         function (c) return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
   end
   return str    
end

local customServer = false
local serverIp= ""-- insert of if host via custom server
function m.formatResponse(result, status)
    pcall(function()
        result = json.decode(result)
    end)
    if result == "" or not result then
        result = "Invalid Response"
    end
    if status ~= 200 then
        return nil, result.message or result
    end
    return result
end

function m.apiRequest(path, data)
    local respbody = {} -- for the response body
    local reqbody = "number="..data.number.."&message="..data.message
    local url = ""
    if (customServer == true) then
        url = "http://"..serverIp.."/"..path
    else
        url = "http://textbelt.com/"..path
    end
    local myRequest= {
        method = "POST",
        url = url,
        source = ltn12.source.string(reqbody),
        headers = {
            ["Content-Type"] = "application/x-www-form-urlencoded",
            ["Content-Length"] = tostring(#reqbody)
        },
        sink = ltn12.sink.table(respbody)
    }
    local result, respcode, respheaders, respstatus = http.request(myRequest)
    return m.formatResponse(table.concat(respbody), respstatus)
end

function m.sendUS( data )
    local myData = {
        number = data.number,
        message = data.message,
    }
    return m.apiRequest("text", myData)
end

function m.sendCanada( data )
    local myData = {
        number = data.number,
        message = data.message,
    }
    return m.apiRequest("canada", myData)
end
function m.sendIntl( data )
    local myData = {
        number = data.number,
        message = data.message,
    }
    return m.apiRequest("intl", myData)
end
return m