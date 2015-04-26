-- Config
pin_pir = 4 -- GPIO2

-- Functions
function pin_active(level)
      local cmd = "ON"
      if (level == 0) then
          cmd = "OFF"
      end

      if connected == 1 then
           m:publish(base_topic ..  "/movement",cmd,0,0,function(conn) end)
      end
end

-- Init
gpio.mode(pin_pir, gpio.INT)
gpio.trig(pin_pir, "both", function(level) pin_active(level) end )
