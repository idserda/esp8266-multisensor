-- Config
ssid = "my-wifi-ssd"
password = "my-wifi-password"

-- Functions
function init() 
     dofile("mqtt.lua")
     dofile("temperature.lua")
     dofile("ldr.lua")
     dofile("pir.lua")
end

-- Init
wifi.setmode(wifi.STATION)
wifi.sta.config(ssid, password)

-- Start timer, check if we're connected every second 
tmr.alarm(0, 1000, 1, function()
     if wifi.sta.status() == 5 then
          tmr.stop(0)
          init()
     end
end)
