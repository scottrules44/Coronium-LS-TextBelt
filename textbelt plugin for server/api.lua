-- copyright Scott Harrison(scottrules44) Aug 11 2016

local api = cloud.api()

local textbelt = require("echo.textbelt")--replace echo with your app name

function api.post.test( in_data )
	return in_data
end

function api.post.sendUS( input )
	local results, error=textbelt.sendUS(input)
	return {result = result, error = error}
end
function api.post.sendCanada( input )
	local results, error=textbelt.sendCanada(input)
	return {result = result, error = error}
end
function api.post.sendIntl( input )
	local results, error=textbelt.sendCanada(input)
	return {result = result, error = error}
end
return api