--local hostIP = "hostIP" -- Your cloud host IP
local appKey = "0000000-0000-0000-0000-0000000000" -- Your cloud app ke
local appName = "echo" -- Your app name
local data = require("data")
local json = require("json")

-- Require and initialize your Coronium LS Cloud
local coronium = require('coronium.cloud')
local cloud = coronium:new(
{
    host = data.hostIP,
    app_key = appKey,
    is_local = false, -- true when working on a local server, false when on AWS/DigitalOcean
    https = true -- false when working on a local server, true when on AWS/DigitalOcean
})
local function check(event)
    if event.phase == "ended" then
        local response = event.response
        print( "check" )
        print( "------------------" )
        print(json.encode(event))
        print("-------------------")
    end
end
local function check1(event)
    if event.phase == "ended" then
        local response = event.response
        print( "check1" )
        print( "------------------" )
        print(json.encode(event))
        print("-------------------")
    end
end
cloud:request("/" .. appName .. "/test", {
        name = "bob",
}, check)
local enterPhoneText = display.newText( "Phone Number", display.contentCenterX, display.contentCenterY-140, native.systemFont )
local enterPhone = native.newTextField( display.contentCenterX, display.contentCenterY-100, 200, 50 )
enterPhone.inputType = "number"
enterPhone:addEventListener( "userInput", function ( e )
    if (e.phase == "submitted") then
        native.setKeyboardFocus( nil )
    end
end )
local submitButton = display.newGroup( )
submitButton.box = display.newRect( submitButton, 0,0, 100, 50 )
submitButton.box:addEventListener( "tap", function ( )
    print(enterPhone.text)
    cloud:request("/" .. appName .. "/sendUS", {
        number = enterPhone.text, message= "hello from coronium ls",
    }, check1)
end )
submitButton.myText  = display.newText( submitButton, "Text", 0,0, native.systemFont, 15 )
submitButton.myText:setFillColor( 0 )
submitButton.x, submitButton.y = display.contentCenterX, display.contentCenterY